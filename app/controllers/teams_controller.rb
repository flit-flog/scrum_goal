class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: [:edit, :update, :destroy]
  
  
  def index
    @teams = Team.all
  end
    
  def show
    @team = Team.find(params[:id])
    @diaries = Diary.where(team_id: @team.id).order("created_at DESC").page(params[:page])

  end
  
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(team_params)
    @team.owner_id = current_user.id
    if @team.save
      @team.users << current_user
      flash[:success] = "チームを作成しました。"
      redirect_to team_path(@team.id)
    else
      flash[:warning] = "チームの作成に失敗しました"
      render 'new'
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to my_team_path(current_user)
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:success] = "チーム情報を更新しました。"
      redirect_to team_path(@team.id)
    else
      flash.now[:warning] = "チーム情報の更新に失敗しました"
      render "edit"
    end
  end
  
  # 承認待ち一覧
  def permits
    @team = Team.find(params[:team_id])
    @permits = @team.permits
  end
  
  # チームメンバー一覧
  def members
    @team = Team.find(params[:team_id])
    @members = @team.team_users
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name,:introduction,:team_image)
  end
  
  def owner?
    team = Team.find(params[:id])
    if team.owner != current_user
      redirect_to request.referer, warning: "チームオーナー権限です"
    end
  end
end
