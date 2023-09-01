class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, :last_name, :gender, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i }, uniqueness: true
  enum gender: { Male: 0, Female: 1, Non_Binary: 2, }, _prefix: true
  validates :username, length: { in: 3..20 }
end
