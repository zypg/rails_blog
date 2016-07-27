class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]


  def show_posts_link
      #byebug
    @topic = Topic.find(params[:topic_id])
    @conversation = Conversation.find(params[:conversation_id])
    @posts = Conversation.find(params[:conversation_id]).posts
    @show_id = params[:conversation_id]
    #byebug
  end
  # GET /conversations
  # GET /conversations.json
  def index
    #@conversations = Conversation.all
    @topic = Topic.find(params[:topic_id])
    @conversations = Conversation.find_by(topic_id: params[:topic_id])
    @current_user = current_user
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    #@conversation = Conversation.find(params[:id])
    @conversation = Conversation.find_by(topic_id: params[:topic_id], id: params[:id])
    @current_user = current_user
  end

  # GET /conversations/new
  def new
    @topic = Topic.find(params[:topic_id])
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
    @topic = Topic.find(params[:topic_id])
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @topic = Topic.find(params[:topic_id])
    @conversation = @topic.conversations.new(conversation_params)
    #@conversation = Conversation.new(conversation_params)
    @conversation.user_id = session[:user_id]

    respond_to do |format|
      if @conversation.save
        flash[:success] = "Conversation was successfully created."
        format.html { redirect_to topic_conversations_path(@topic) }
        #, notice: 'Conversation was successfully created.'
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    @topic = Topic.find(params[:topic_id])

    respond_to do |format|
      if @conversation.update(conversation_params)
        flash[:success] = "Conversation was successfully updated."
        format.html { redirect_to topic_conversations_path(@topic) }
        #, notice: 'Conversation was successfully updated.'
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @topic = Topic.find(params[:topic_id])
    @conversation = Conversation.find_by(topic_id: params[:topic_id], id: params[:id])
    @conversation.topic_id = nil
    @conversation.user_id = nil
    @conversation.destroy
    respond_to do |format|
      flash[:success] = "Conversation was successfully destroyed."
      format.html { redirect_to topic_conversations_path(@topic.id) }
      #, notice: 'Conversation was successfully destroyed.'
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:context)
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
