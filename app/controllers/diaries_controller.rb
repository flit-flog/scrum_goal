class DiariesController < ApplicationController
   before_action :authenticate_user!
   before_action :team_member?, only: [:destroy, :show]
  
  def new
    @diary = current_user.diaries.new
  end
  
  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      flash[:success] = "投稿に成功しました。"
      redirect_to diary_path(@diary)
    else
      flash[:warning] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_comment = DiaryComment.new
  end
  
  def edit
    @diary = Diary.find(params[:id])
  end
  
  def update
    @diary = Diary.find(params[:id])
    @diary.update(diary_params)
    redirect_to diary_path(@diary)
  end
  
  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to  user_path(current_user)
  end
  
  # いいねした人の表示
  def favorite
    @diary = Diary.find(params[:id])
    @favorited_users = @diary.favorited_users
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:title,:body,:team_id)
  end
  
  # チームに所属しているか確認
  def team_member?
    diary = Diary.find(params[:id])
    unless current_user.team_users.exists?(team_id: diary.team_id)
      flash[:warning] = "チームメンバーではありません"
      redirect_to user_path(current_user)
    end
  end
  
end
