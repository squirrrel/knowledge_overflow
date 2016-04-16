class AnswersController < ApplicationController
  include SharedBeforeFilters
  include CalculateVotes

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
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new answer_params.merge user_id: current_user.id
    @answer.build_post embedded_post_params

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
      if @answer.post.update(embedded_post_params)
        format.js { head :no_content }
        format.json { render :show, status: :ok, location: @answer }
      else
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
    @total_votes = calculate_votes()

    if @answer.post.update votes: @total_votes
      respond_to do |format|
        format.js { render 'shared/update_votes.js.erb' }
      end
    end
  end

  private
  def set_entity
    @answer = Answer.find(params[:id])
  end

  def set_vote
    @vote = VotesCloud.find_or_create_by(user_id: current_user.id, "#{@answer.namespace}_id": @answer.id)
  end

  def set_current_votes_number
    @entity_current_votes = @answer.votes
  end

  def answer_params
    params.require(:answer).permit(:question_id)
  end

  def embedded_post_params
    params.require(:answer).permit(post: :body)[:post]
  end
end
