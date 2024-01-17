class TeamUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @team = Team.find(params[:team_id])
    @permit = Permit.find(params[:permit_id])
    @team_user = TeamUser.create(user_id: @permit.user_id, team_id: params[:team_id])
    @permit.destroy #参加希望者リストから削除する
    redirect_to request.referer
  end

  def destroy
    team = Team.find(params[:team_id])
    user = current_user
    team.users.delete(user)
    redirect_to root_path
  end
end
