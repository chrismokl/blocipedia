class Wiki < ActiveRecord::Base
  extend FriendlyId
  has_many :articles
  has_many :collaborations
  has_many :users, through: :collaborations
  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness: true
end
