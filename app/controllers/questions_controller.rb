class QuestionsController < ApplicationController
  include SetParameters
  include CalculateVotes

  before_action :set_tag_cloud, only: [:index, :show, :tagged]
  before_action :set_questions, only: [:index, :tagged]
  # GET /questions
  # GET /questions.json
  def index
  end

  def tagged
    @questions = @questions.tagged_with(params[:tag]) if params[:tag]

    render :index
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    # @question.user_id != current_user.id
    return if @question.user_id == 2

    unless ViewsCloud.find_by(user_id: 3, question_id: @question.id)
      @question.update(views: @question.views + 1)
      ViewsCloud.create user_id: 3, question_id: @question.id
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.build_post
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new question_params.merge user_id: 1
    @question.build_post embedded_post_params

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @cid = @question.cid
    @total_votes = calculate_votes()

    if @question.post.update(votes: @total_votes)
      respond_to do |format|
        format.js { render 'shared/update_votes.js.erb' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @question = Question.find(params[:id])
    end

    def set_questions
      @questions = Question.preload(:user, :post).order('created_at DESC').page(params[:page]).per(10)
    end

    def set_tag_cloud
      @tags = Question.tag_counts_on(:tags)
    end

    def set_vote
      @vote = VotesCloud.find_or_create_by(user_id: 1, "#{@question.namespace}_id": @question.id)
    end

    def set_current_votes_number
      @entity_current_votes = @question.votes_number
    end

    def question_params
      params.require(:question).permit(:header, :tag_list)
      # params.permit(:page, :per_page, :increase, :decrease, :tag)
    end

    def embedded_post_params
      params.require(:question).permit(post_attributes: :body)[:post_attributes]
    end
end
