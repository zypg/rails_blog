class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #在 Application 控制器中引入 Sessions 辅助模块
  include SessionsHelper

end
