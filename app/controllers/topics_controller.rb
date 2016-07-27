class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    @current_user = current_user
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @current_user = current_user
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit

  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = session[:user_id]

    respond_to do |format|
      if @topic.save
        flash[:success] = "Topic was successfully created"
        format.html { redirect_to @topic }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        flash[:success] = "Topic was successfully updated."
        format.html { redirect_to @topic }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.user_id = nil
    @topic.destroy
    respond_to do |format|
      flash[:success] = "Topic was successfully destroyed."
      #format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:term)
    end


  def showComments
    @commets = Post.find(param[:id]).conversations

    #render
  end

  # 确保用户已登录
  def logged_in_user
    unless logged_in?

      store_location

      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
