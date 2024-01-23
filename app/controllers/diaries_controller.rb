class DiariesController < ApplicationController
   before_action :authenticate_user!
   before_action :team_member?, only: [:destroy, :show, :favorite]
  
  def new
    @diary = current_user.diaries.new
    #@team = Team.find_by(id: params[:team_id])
  end
  
  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to diary_path(@diary)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      redirect_to new_diary_path
    end
  end
  
  # def index
  #   @team = Team.find(params[:team_id])
  #   @diaries = Diary.where(team_id: @team.id)
  # end
  
  def show
    @diary = Diary.find(params[:id])
    @diary_comment = DiaryComment.new
  end
  
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to  team_path(diary.team_id)
  end
  
  def favorite
    diary = Diary.find(params[:id])
    @favorited_users = diary.favorited_users
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:title,:body,:team_id)
  end
  
  def team_member?
    diary = Diary.find(params[:id])
    unless current_user.team_users.exists?(team_id: diary.team_id)
      redirect_to root_path, alert: "チームメンバーではありません"
    end
  end
  
end
