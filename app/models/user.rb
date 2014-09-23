class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :collaborations
  has_many :wikis, through: :collaborations
  friendly_id :username, use: :slugged

  validates :username, presence: true, uniqueness: true
end
