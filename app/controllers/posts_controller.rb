class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]


  def getPosts
    @conversation = Conversation.find(params[:conversation_id])
    @posts = Post.find_by(conversation_id: params[:conversation_id])
  end

  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @conversation = Conversation.find(params[:conversation_id])
    @posts = Post.find_by(conversation_id: params[:conversation_id])
    @current_user = current_user
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #@post = Post.find(params[:id])
    @conversation = Conversation.find(params[:conversation_id])
    @post = Post.find_by(conversation_id: params[:conversation_id],id: params[:id])
    @current_user = current_user
  end

  # GET /posts/new
  def new
    @conversation = Conversation.find(params[:conversation_id])
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    #@post = Post.find(params[:id])
    @conversation = Conversation.find(params[:conversation_id])
    @post = Post.find_by(conversation_id: params[:conversation_id],id: params[:id])
    byebug
  end

  # POST /posts
  # POST /posts.json
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @post = @conversation.posts.new(post_params)
    #@post = Post.new(post_params)

    @post.user_id = session[:user_id]

    respond_to do |format|
      if @post.save
        flash[:success] = "Post was successfully created."
        format.html { redirect_to topic_conversation_posts_path(@conversation.topic_id,@conversation) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    byebug
    @conversation = Conversation.find(params[:conversation_id])

    @post = Post.find_by(conversation_id: params[:conversation_id],id: params[:id])
    byebug

    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = "Post was successfully updated."
        format.html { redirect_to topic_conversation_posts_path(@conversation.topic_id,@conversation) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @conversation = Conversation.find(params[:conversation_id])
    @post = Post.find_by(conversation_id: params[:conversation_id],id: params[:id])
    @post.user_id = nil
    @post.conversation_id = nil
    @post.destroy
    respond_to do |format|
      flash[:success] = "Post was successfully destroyed."
      format.html { redirect_to topic_conversation_posts_path(@conversation.topic_id,@conversation)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:context)
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
