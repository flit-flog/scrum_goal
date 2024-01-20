class Diary < ApplicationRecord
    
    # action textの使用
    has_rich_text :body
    
    belongs_to :user
    belongs_to :team
    has_many :diary_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    
    validates :title, presence: true
    validates :body, presence: true
    
    # def get_diary_image(width, height)
    #     profile_image.variant(resize_to_limit: [width, height]).processed
    # end
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
end
