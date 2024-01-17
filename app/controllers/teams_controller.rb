class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :update, :destroy]
  
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
    if @team.save
      @team.users << current_user
      redirect_to team_path(@team.id)
    else
      render 'new'
    end
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
  
  def permits
    @team = Team.find(params[:id])
    @permits = @team.permits.page(params[:page])
  end

  
  private
  
  def team_params
    params.require(:team).permit(:name,:introduction,:image)
  end
  
  def owner?
    team = Team.find(params[:id])
    if team.owner != current_user
      redirect_to team_path(team.id)
    end
  end
end
