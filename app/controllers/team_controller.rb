class TeamController < ApplicationController

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
        @team = Team.find_by_name(params[:team_name])

        if @team
            redirect to "/login"
        else
            @team = Team.create(:name => params[:team_name], :password => params[:password])
            login(params[:team_name], params[:password])

            redirect to "/team/#{@team.slug}"
        end
    end

    post '/logout' do
        logout!
    end
end