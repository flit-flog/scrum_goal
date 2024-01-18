class PermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    permit = current_user.permits.new(team_id: params[:id])
    permit.save
    redirect_to request.referer, notice: "グループへ参加申請をしました"
  end

  def destroy
    permit = current_user.permits.find_by(team_id: params[:team_id])
    # @permit = Permit.find(params[:permit_id])
    permit.destroy
    redirect_to request.referer, alert: "グループへの参加申請を取消しました"
  end

end
