class TeamUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :owner?, only: [:create, :banishment]

  
  def create
    @team = Team.find(params[:team_id])
    @permit = Permit.find(params[:permit_id])
    @team_user = TeamUser.create(user_id: @permit.user_id, team_id: params[:team_id])
    @permit.destroy #参加希望者リストから削除する
    flash[:success] = "申請を許可しました"
    redirect_to request.referer, notice: 

  end

  def destroy
    team = Team.find(params[:team_id])
    team.users.delete(current_user)
    Diary.where(team_id: team.id, user_id: current_user.id).destroy_all
    flash[:warning] = "チームから脱退しました"
    redirect_to user_path(current_user)
  end
  
  def banishment
    member = TeamUser.find(params[:team_user_id])
    member.destroy
    Diary.where(team_id: member.team_id, user_id: member.user_id).destroy_all
    flash[:warning] = "チームから追放しました"
    redirect_to request.referer
  end
  
  private 
  
  def owner?
    team = Team.find(params[:team_id])
    if team.owner != current_user
      redirect_to request.referer, alert: "チームオーナー権限です"
    end
  end
end
