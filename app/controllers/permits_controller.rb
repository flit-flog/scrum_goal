class PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    team = Team.find(params[:team_id])
    permit = current_user.permits.new(team_id: team.id)
    if permit.save
      flash[:success] = "参加申請をしました"
      redirect_to request.referer
    else
      redirect_to my_team_path
    end
  end

  def destroy
    permit = current_user.permits.find_by(team_id: params[:team_id])
    permit.destroy
    flash[:warning] = "参加申請を取消しました"
    redirect_to request.referer 
  end
  
  # 参加申請拒否
  def refuse_permit
    @permit = Permit.find(params[:permit_id])
    @permit.destroy
    flash[:warning] = "参加申請を拒否しました"
    redirect_to request.referer
  end

end