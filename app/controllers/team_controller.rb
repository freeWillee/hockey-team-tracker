class TeamController < ApplicationController
    get '/signup' do
        
        erb :"/teams/new"
    end

    get '/team' do
        @teams = Team.all
        
        erb :"teams/index"
    end

    get '/team/:slug' do
        binding.pry
        
        if logged_in? && (Team.find_by_slug(params[:slug]).name == session[:team_name])
            @team = Team.find_by_name(session[:team_name])
            erb :"teams/show"
        else
            redirect to '/login'
        end
    end

    post '/team' do
        binding.pry
        @team = Team.find_by_name(params[:team_name])

        if @team
            redirect to "/login"
        else
            @team = Team.create(:name => params[:team_name], :password => params[:password])
            login(params[:team_name], params[:password])
            binding.pry
            redirect to "/team/#{@team.slug}"
        end
    end

    get '/team/:team_name/:profile_slug' do
        if logged_in?
            @staff = Staff.find_by_slug(params[:profile_slug])
            @player = Player.find_by_slug(params[:profile_slug])
            
            if @player
                erb :"players/show"
            else
                erb :"staff/show"
            end
        else
            redirect to '/login'
        end
    end

    post '/logout' do
        logout!
    end
end