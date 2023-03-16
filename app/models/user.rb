class User < ApplicationRecord
  before_save { email.downcase! }    #  before_save { self.email = email.downcase }
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 50 }
  validates :email,    presence: true, uniqueness: true, length: { maximum: 250 }, format: { with: URI::MailTo::EMAIL_REGEXP } # Thành
  has_many :tasks
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
