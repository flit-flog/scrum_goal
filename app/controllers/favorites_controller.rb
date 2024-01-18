class FavoritesController < ApplicationController
  
  def create
    diary = Diary.find(params[:diary_id])
    favorite = current_user.favorites.new(diary_id: diary.id)
    favorite.save
    redirect_to team_diary_path(diary.team, diary)
  end

  def destroy
    diary = Diary.find(params[:diary_id])
    favorite = current_user.favorites.find_by(diary_id: diary.id)
    favorite.destroy
    redirect_to team_diary_path(diary.team, diary)
  end
  
  def index
    diary = Diary.find(params[:diary_id])
    favorites = Favorite.where(diary_id: diary.id).pluck(:user_id)
    @favorite_users = User.find(favorites)
  end
end
