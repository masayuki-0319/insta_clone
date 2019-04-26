class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  # :omniauthable, :omniauth_providers[:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_save { self.email = email.downcase }
  validates :user_name, presence: true, length: { in: 3..50}
  validates :pen_name, presence: true, length: { in: 3..50}
  validates :email, uniqueness: { case_sensitive: false }
  has_many :photos, dependent: :destroy
end
