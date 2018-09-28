class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "mypassword"
    end

    # HOMEPAGE ROUTE
    get '/' do
        erb :index
    end

    # EDIT PLAYER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    patch '/team/:team_slug/player/:player_slug' do

        @team = Team.find_by_name(session[:team_name])
        @player = Player.find_by_slug(params[:player_slug])
        @editing_player_name = params[:player][:name]
        @salary_range_selected = Salary.find_by_id(params[:player][:salary_id].to_i)

        if player_exists?(@editing_player_name) && @editing_player_name != @player.name
            #RAISE MESSAGE ERROR THAT PLAYER ALREADY EXISTS
            existing_player = Player.find_by_name(@editing_player_name)

            redirect to "/team/#{params[:team_slug]}/player/#{existing_player.slug}"
        else
            #Change name if not empty            
            if !@editing_player_name.empty?
                @player.name = @editing_player_name
            end
            
            #Clear player positions & update with selected
            @player.positions.clear
            @player.save
            params[:positions].each do |position|
                @player.positions << Position.find_by_id(position.to_i)
            end

            #Update salary range if necessary
            @player.salary = @salary_range_selected if @player.salary != @salary_range_selected

            #Save all changes to database
            @player.save

            #redirect user to player profile after creating
            redirect to "/team/#{@player.team.slug}/player/#{@player.slug}"            
        end
    end

    # DELETE PLAYER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    delete '/team/:team_slug/player/:player/delete' do
        @player = Player.find_by_slug(params[:player])
        @player.delete

        erb :"players/delete"
    end

    # DELETE USER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    delete '/user/:user_slug/delete' do
        @user = User.find_by_slug(params[:user_slug])
        @user.delete

        erb :"users/delete"
    end

    #HELPER METHODS
    helpers do
        def login(username, password)
            user = User.find_by(:username => username)

            if user && user.authenticate(password)
                session[:username] = user.username
            else
                redirect to '/login'
            end
        end

        def logged_in?
            !!current_user
        end

        def current_user
            @current_user ||= User.find_by(:username => session[:username]) if session[:username]
        end

        def logout!
            session.clear

            redirect to '/'
        end

        def player_exists?(player_name)
            !!Player.find_by_name(player_name)
        end

        def is_super_user?
            !!current_user.super_user == 1
        end

    end

end