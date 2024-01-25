class HomesController < ApplicationController
    def top
    end
    
    def guest_sign_in
        user = User.find_or_create_by!(email: 'guest@example.com') do |user|
            user.password = SecureRandom.urlsafe_base64
            user.name = "ゲスト"
        end
        sign_in user
        flash[:success] = "ゲストユーザーとしてログインしました。"
        redirect_to my_team_path(user)
    end
end
