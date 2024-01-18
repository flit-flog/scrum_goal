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
      flash[:notice] = "チームを作成しました。"
      redirect_to team_path(@team.id)
    else
      render 'new'
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end

  def update
    if @team.update(team_params)
      flash[:notice] = "チーム情報を更新しました。"
      redirect_to team_path(@team.id)
    else
      render "edit"
    end
  end
  
  def permits
    @team = Team.find(params[:id])
    @permits = @team.permits
    # @permits = @team.permits.page(params[:page])
    # @permits = Permits.where(team_id)
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
