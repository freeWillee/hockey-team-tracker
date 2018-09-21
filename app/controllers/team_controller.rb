class TeamController < ApplicationController
    get '/signup' do
        
        erb :"/teams/new"
    end

    get '/team' do
        if logged_in?
            @team = Team.find_by_name(session[:team_name])
            erb :"teams/show"
        else
            redirect to '/'
        end
    end
end