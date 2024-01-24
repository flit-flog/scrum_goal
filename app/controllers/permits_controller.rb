class PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    team = Team.find(params[:team_id])
    permit = current_user.permits.new(team_id: team.id)
    if permit.save
      redirect_to request.referer, notice: "チームへ参加申請をしました"
    else
      redirect_to teams_path
    end
  end

  def destroy
    # permit = Permit.find(params[:permit_id])
    # @permit = Permit.find(params[:permit_id])
    permit = current_user.permits.find_by(team_id: params[:team_id])
    # # @permit = Permit.find(params[:permit_id])
    permit.destroy
    redirect_to request.referer, alert: "チームへの参加申請を取消しました"
  end
  
  
  def refuse_permit
    @permit = Permit.find(params[:permit_id])
    @permit.destroy
    redirect_to request.referer, alert: "チームへの参加申請を取消しました"
  end

end