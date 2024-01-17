class DiariesController < ApplicationController
  
  def new
    @diary = current_user.diaries.new
    #@team = Team.find_by(id: params[:team_id])
  end
  
  def create
    @team = Team.find(params[:team_id])
    @diary = current_user.diaries.new(diary_params)
    @diary.team_id = @team.id
    @diary.save
    redirect_to team_diaries_path(@team,@diary)
  end
  
  def index
    @diaries = Diary.where(team_id: params[:team_id])
  end
  
  def show
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:title,:body)
  end
end
