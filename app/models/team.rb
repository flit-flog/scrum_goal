class Team < ApplicationRecord
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :permits, dependent: :destroy
  has_many :diaries, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'


  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :team_image
  
  def get_team_image(width, height)
    unless team_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      team_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      team_image.variant(resize_to_limit: [width, height]).processed
  end
end
