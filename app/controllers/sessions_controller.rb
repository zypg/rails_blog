class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 登入用户,然后重定向到topics/index(root page)
      log_in user
      #redirect_to root_path
      ########测试测试################
      redirect_back_or user

      #if user.activated?
      #  log_in user
      #  params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #  redirect_back_or user
      #else
      #  message  = "Account not activated. "
      #  message += "Check your email for the activation link."
      #  flash[:warning] = message
      #  redirect_to root_path
      #end

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    #log_out if logged_in?

    log_out
    redirect_to root_path
  end

end
