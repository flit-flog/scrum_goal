class Team < ApplicationRecord
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :diaries, dependent: :destroy


  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :image
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
