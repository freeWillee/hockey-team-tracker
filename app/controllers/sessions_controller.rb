class SessionsController < ApplicationController
    get '/login' do

        erb :"/sessions/login"
    end

    post '/sessions' do
        login(params[:team_name], params[:password])
        binding.pry
        @team = Team.find_by_name(params[:team_name])
        
        redirect to "/team/#{@team.slug}"
    end

    
end