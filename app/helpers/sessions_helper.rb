module SessionsHelper
  # 登入指定的用户
  def log_in(user)
	   session[:user_id] = user.id
  end

  #返回当前登陆的用户（如果有的话） 原本的current_user
  # def current_user
  #   @current_user = @current_user || User.find_by(id: session[:user_id])
  # end

  #为了持续记忆修改后的current_user
  def current_user
    if session[:user_id] # 如果加密session ID能找到
        @current_user ||= User.find_by(id: session[:user_id]) # 以前就有@current_user(不退出浏览器不会消失)，或者没有的话就赋值
    elsif cookies.signed[:user_id] # 加密cookie ID能找到的话
        user = User.find_by(id: cookies.signed[:user_id])  # 赋值
        if user && user.authenticated?(cookies[:remember_token]) # 加密id找得到还要令牌对的上
            log_in user # 登入并且存入session id到浏览器端
            @current_user = user #这个赋值为了实现后面的logged_in?方法
        end
    end
  end

  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
  	!current_user.nil?
  end

  def remember(user)
  	user.remember #这一步是把token的哈希摘要赋值给remember_digest，存进user数据库，
                  #并且这一步包含self.remember_token = User.new_token这个语句，创建了remember_token这个虚拟属性。
  	cookies.permanent.signed[:user_id] = user.id # 加密ID存到cookie
  	cookies.permanent[:remember_token] = user.remember_token # token存到cookie
  end

    # 忘记持久会话
  def forget(user)
  	user.forget
  	cookies.delete(:user_id)
  	cookies.delete(:remember_token)
  end

  # 没有持续记忆前的退出当前用户
  # def log_out
  #   session.delete(:user_id)
  #   @current_user = nil
  # end

  # 退出当前用户
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
