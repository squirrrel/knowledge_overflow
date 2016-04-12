class AnswersController < ApplicationController
  include Calculate_Votes
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :vote]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.joins(:post).order('votes DESC')
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    # respond_to do |format|
    #   format.js { render 'edit' }
    # end
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new answer_paramas.merge user_id: 5
    @answer.build_post post_params

    if @answer.save
      respond_to do |format|
        format.js { render 'load_answer' }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @cid = @answer.cid
    @votes = calculate_votes(@answer)

    if @answer.post.update votes: @votes
      respond_to do |format|
        format.js { render 'shared/update_votes.js.erb' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:answer).require(:post).permit(:body)
    end

    def answer_paramas
      params.require(:answer).permit(:question_id)
    end
end
