class DiariesController < ApplicationController
  
  def new
    @diary = current_user.diaries.new
    #@team = Team.find_by(id: params[:team_id])
  end
  
  def create
    @team = Team.find(params[:team_id])
    @diary = current_user.diaries.new(diary_params)
    @diary.team_id = @team.id
    if @diary.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to team_diary_path(@team,@diary)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
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
    redirect_to  team_diaries_path(params[:team_id])
  end
  
  def favorite
    diary = Diary.find(params[:diary_id])
    @favorited_users = diary.favorited_users
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:title,:body)
  end
end
