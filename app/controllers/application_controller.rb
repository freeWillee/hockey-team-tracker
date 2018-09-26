class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "mypassword"
    end

    get '/' do
        erb :index
    end

    # EDIT PLAYER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    patch '/team/:team_slug/player/:player_slug' do
        binding.pry
    end

    # DELETE PLAYER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    delete '/team/:team_slug/player/:player/delete' do
        @player = Player.find_by_slug(params[:player])
        @player.delete

        erb :"players/delete"
    end

    helpers do
        def login(team_name, password)
            team = Team.find_by_name(team_name)

            if team && team.authenticate(password)
                session[:team_name] = team.name
            else
                redirect to '/login'
            end
        end

        def logged_in?
            !!current_team
        end

        def current_team
            @current_team ||= Team.find_by(:name => session[:team_name]) if session[:team_name]
        end

        def logout!
            session.clear

            redirect to '/'
        end

        def player_exists?(player_name)
            !!Player.find_by_name(player_name)
        end
    end

end