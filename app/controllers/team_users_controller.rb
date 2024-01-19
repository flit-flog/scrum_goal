class TeamUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :owner?, only: [:create, :banishment]

  
  def create
    @team = Team.find(params[:team_id])
    @permit = Permit.find(params[:permit_id])
    @team_user = TeamUser.create(user_id: @permit.user_id, team_id: params[:team_id])
    @permit.destroy #参加希望者リストから削除する
    redirect_to request.referer, notice: "チームへの参加を許可しました"

  end

  def destroy
    team = Team.find(params[:team_id])
    # user = current_user
    team.users.delete(current_user)
    redirect_to user_path(current_user), alert: "チームオーナー権限です"
  end
  
  def banishment
    member = TeamUser.find(params[:team_user_id])
    member.destroy
    redirect_to request.referer, alert: "チームから追放しました"
  end
  
  private 
  
  def owner?
    team = Team.find(params[:team_id])
    if team.owner != current_user
      redirect_to request.referer, alert: "チームオーナー権限です"
    end
  end
end
