class TeamController < ApplicationController
    get '/signup' do
        
        erb :"/teams/new"
    end

    get '/team' do
        @teams = Team.all
        
        erb :"teams/index"
    end

    get '/team/:slug' do
        
        if logged_in? && (Team.find_by_slug(params[:slug]).name == session[:team_name])
            @team = Team.find_by_name(session[:team_name])
            erb :"teams/show"
        else
            redirect to '/login'
        end
    end

    post '/team' do
        @team = Team.find_by_name(:params[:team_name])
        if @team
            redirect to "/login"
        else
            @team = Team.new(:team_name => params[:team_name], :password => params[:password])

            redirect to "/team"
        end
    end

    get '/team/:team_name/:profile_slug' do
        @staff = Staff.find_by_slug(params[:profile_slug])
        @player = Player.find_by_slug(params[:profile_slug])
        
        if @player
            erb :"players/show"
        else
            erb :"staff/show"
        end
    end

    post '/logout' do
        logout!
    end
end