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

    end

end