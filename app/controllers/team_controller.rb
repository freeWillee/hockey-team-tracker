class TeamController < ApplicationController

    get '/team' do
        @teams = Team.all
        
        erb :"teams/index"
    end

    get '/team/new' do
        if logged_in?
            erb :"teams/new"
        else
            redirect to "/login"
        end
    end

    get '/team/:team_slug' do
        if logged_in?
            @team = Team.find_by_slug(params[:team_slug])
            @current_user = User.find_by_username(session[:username])

            erb :"teams/show"
        else
            redirect to '/login'
        end
    end

    #CREATE A TEAM - ONLY SUPERUSER CAN DO THIS
    post '/team' do
        @team = Team.new(name: params[:team_name].split.map(&:capitalize).join(' '))

        if !@team.valid?
            erb :"/teams/error"
        else
            @team.save
            @user = User.find_by_username(session[:username])
            @user.team = @team
            @user.save
            redirect to "/team/#{@team.slug}"
        end
    end

    post '/logout' do
        logout!
    end
end