class PlayersController < ApplicationController

    get '/team/:team_name/:profile_slug' do
        @staff = Staff.find_by_slug(params[:profile_slug])
        @player = Player.find_by_slug(params[:profile_slug])
        
        if @player
            erb :"players/show"
        else
            erb :"staff/show"
        end
    end

end