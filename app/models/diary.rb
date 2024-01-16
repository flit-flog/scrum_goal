class Diary < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_one_attached :diary_image
end
