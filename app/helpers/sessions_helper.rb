module SessionsHelper

  # 登入指定的用户
  def log_in(user)
    # Rails 提供的 session 方法
    # 此方法 与 生成的Sessions控制器 没有关系
    session[:user_id] = user.id
  end

  # 返回当前登录的用户
  #def current_user
  #  if @current_user.nil?
  #    @current_user = User.find_by(id: session[:user_id])
  #  else
  #    @current_user
  #  end
  #  #@current_user ||= User.find_by(id: session[:user_id])
  #end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 如果用户已登录,返回 true,否则返回 false
  def logged_in?
    !current_user.nil?
  end

  # 退出当前用户
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # 如果指定用户是当前用户,返回 true
  def current_user?(user)
    user == current_user
  end

  # 重定向到存储的地址或者默认地址
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # 存储后面需要使用的地址
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
