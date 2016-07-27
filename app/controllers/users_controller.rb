class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only:[:edit,:update]

  def index
    #@users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless FILL_IN
    #debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save

      #login
      log_in @user
      flash[:success] = "Welcome to the Rails Community!"

      #UserMailer.account_activation(@user).deliver_now
      #@user.send_activation_email
      #flash[:info] = "Please check your email to activate your account."

      redirect_to root_path
      #
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      #show_path
      redirect_to @user
    else
      render 'edit'
    end
  end

  # 确保用户已登录
  def logged_in_user
    unless logged_in?

      store_location

      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # 确保是正确的用户
  def correct_user
    @user = User.find(params[:id])
    #redirect_to(root_url) unless @user == current_user
    redirect_to(root_url) unless current_user?(@user)
  end

  private
      def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
      end




end
