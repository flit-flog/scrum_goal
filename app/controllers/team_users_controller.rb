class TeamUsersController < ApplicationController
  def create
    # 自分のIDを持ったteam_userを作成する。
    team_user = current_user.team_users.new(team_id: params[:team_id])
    team_user.save
    redirect_to request.referer
  end

  def destroy
    # 自分のIDを持ったgroup_userの中からさらに、group_idカラムのデータがグループ詳細ページと一緒のデータを探す。
    team_user = current_user.team_users.find_by(team_id: params[:team_id])
    team_user.destroy
    redirect_to request.referer
  end
end
