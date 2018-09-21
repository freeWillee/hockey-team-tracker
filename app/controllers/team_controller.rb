class TeamController < ApplicationController
    get '/signup' do
        
        erb :"/teams/new"
    end

    get '/team' do
        "You are signed in as #{session[:team_name]}"
    end
end