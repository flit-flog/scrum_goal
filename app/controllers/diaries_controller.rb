class DiariesController < ApplicationController
  
  def new
    @diary = Diary.new 
  end
  
  def create
    @diary = Diary.new(diary_params)
    @diary.user_id= current_user.id
  end
end
