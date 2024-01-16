class TeamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @teams = Team.all
  end
    
  def show
    @team = Team.find(params[:id])
  end
  
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(team_params)
    @team.owner_id = current_user.id
    # if @team.save
    @team.save
      # チーム詳細に変更
      redirect_to teams_path
    # else
      # render 'new'
    # end
  end
  
  def edit
    @team = Team.find(params[:id])
  end

  def update
    if @team.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name,:introduction,:image)
  end
end
