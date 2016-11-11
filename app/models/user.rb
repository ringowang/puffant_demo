class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :meetups, dependent: :destroy
  # 返回一个随机令牌
  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  # 返回指定字符串的哈希摘要
  def User.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  												  BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)
  end

  def remember
		self.remember_token = User.new_token #返回随机令牌
    #把token的哈希摘要赋值给remember_digest，存进user数据库
		update_attribute(:remember_digest, User.digest(remember_token))
	end

  # 如果指定的令牌和摘要匹配，返回 true
  def authenticated?(remember_token)
    return false if remember_digest.nil?
  	#bcrypt的方法，返回bool，不必深究
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
	   update_attribute(:remember_digest, nil)
  end
end
