class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :permits, dependent: :destroy
  has_many :diaries, dependent: :destroy
  
  has_one_attached :user_image
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
