class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @diaries = @user.diaries
    end
    
    def edit
         @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "ユーザー情報を更新しました。"
            redirect_to user_path(@user)
        else
            render "edit"
        end
    end
    
    def destroy
    end
    
    def my_team
        @my_teams = current_user.teams
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
