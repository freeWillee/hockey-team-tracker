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
            @user = current_user

            erb :"teams/show"
        else
            redirect to '/login'
        end
    end

    #CREATE A TEAM - ONLY SUPERUSER CAN DO THIS
    post '/team' do
        # Create team name
        @team = Team.new(name: params[:team_name].split.map(&:capitalize).join(' '))

        #Save only if team passes validations
        if !@team.valid?

            erb :"/teams/error"
        else
            # Define team roster positions (Forward & Defense only (beta)) and save to database
            Position.create(position: "Forward")
            Position.create(position: "Defense")

            # Define baseline salaries and save to database
            Salary.create(amount: 1000000)
            Salary.create(amount: 2000000)
            Salary.create(amount: 3000000)

            #Save team to database
            @team.save

            #Attach team to currently logged-in super user
            user = User.find_by_username(session[:username])
            user.team = @team
            user.save

            redirect to "/team/#{@team.slug}"
        end
    end

    post '/logout' do
        logout!
    end
end