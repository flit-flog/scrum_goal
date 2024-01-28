class DiaryCommentsController < ApplicationController
     before_action :authenticate_user!
     
  def create
    diary = Diary.find(params[:diary_id])
    comment = current_user.diary_comments.new(diary_comment_params)
    comment.diary_id = diary.id
    if comment.save
      flash[:success] = "コメントを投稿しました"
      redirect_to diary_path(diary)
    else
      flash[:warning] = "入力内容がありません"
      redirect_to request.referer
    end
  end
  
  def destroy
    DiaryComment.find(params[:id]).destroy
    flash[:warning] = "コメントを削除しました"
    redirect_to diary_path(params[:diary_id])
  end
  
  private

  def diary_comment_params
    params.require(:diary_comment).permit(:comment)
  end
end
