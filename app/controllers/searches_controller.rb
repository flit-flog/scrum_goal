class SearchesController < ApplicationController
   before_action :authenticate_user!
   
  def search_teams
    @content = params[:content]
    @search_teams = Team.where('name LIKE ?', '%' + @content + '%')
  end
end
