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
        #instance variable definitions
        @team = Team.find_by_name(current_user.team.name)
        @player = Player.find_by_slug(params[:player_slug])
            #account for all lowercase names in input box...
        @edit_name = params[:name].split.map(&:capitalize).join(' ')
        @edit_birth_year = params[:birth_year].to_i
        @edit_position = params[:position_id].to_i

        if params[:salary][:new_amt].empty?
            @edit_salary = Salary.find_by_amount(params[:salary][:amount].to_i)
        else
            @edit_salary = Salary.create(amount: params[:salary][:new_amt])
        end

        @goals_target = GoalTarget.find_or_create_by(target: params[:goals_target].to_i) if params[:goals_target] != ""
        @assists_target = AssistTarget.find_or_create_by(target: params[:assists_target].to_i) if params[:assists_target] != ""
        @goals_edit = params[:goals_to_date].to_i
        @assists_edit = params[:assists_to_date].to_i

        #If the player already exists in database, redirect to that player's profile page
        if player_exists?(@edit_name) && edit_name_unique?(@edit_name, @player.name)
            redirect to "/team/#{@team.slug}/player/#{@player.slug}"
        else
            #Change name if not empty            
            @player.name = @edit_name.strip if !@edit_name.empty?
            
            #Update player position if not empty
            @player.position = Position.find_by_id(@edit_position) if @edit_position != 0

            #Update salary range if necessary
            @player.salary = @edit_salary if !!@edit_salary

            #Save season stats
            @player.GoalTarget = @goals_target if @goals_target != nil

            @player.AssistTarget = @assists_target if @assists_target != nil

            @player.goals = @goals_edit if @goals_edit != 0

            @player.assists = @assists_edit if @assists_edit != 0

            #Save all changes to database
            @player.save

            #redirect user to player profile after creating
            redirect to "/team/#{@team.slug}/player/#{@player.slug}"             
        end
    end

    # DELETE PLAYER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    delete '/team/:team_slug/player/:player/delete' do
        @player = Player.find_by_slug(params[:player])
        @player.delete
        @user = current_user

        erb :"players/delete"
    end

    # EDIT USER ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    patch '/user/:user_slug' do

        @user = User.find_by_slug(params[:user_slug])
        @editing_user_name = params[:user][:username]
        @editing_email = params[:user][:email]
        @editing_password = params[:user][:password]
        @profile_updates = []

        if user_exists?(@editing_user_name)
            #RAISE MESSAGE ERROR THAT PLAYER ALREADY EXISTS
            @error_message = "Username already taken.  Please choose another."
            @selected_user = User.find_by_slug(params[:user_slug])

            erb :"/users/edit_user"
        #DISPLAY ERROR MESSAGE IF NOTHING IS SUBMITTED
        elsif @editing_user_name.empty? && @editing_email.empty? && @editing_password.empty?
            @error_message = "You have not changed any profile details."
            @selected_user = User.find_by_slug(params[:user_slug])

            erb :"/users/edit_user"
        else
            #Change username if not empty            
            if !@editing_user_name.empty?
                @user.username = @editing_user_name.strip
                #UPDATE SESSION TO REFLECT NEW USER IF CURRENT USER IS NOT ADMIN
                if !current_user.super_user?
                    session[:username] = @user.username
                end
                @profile_updates << "username"
            end

            #Change email if not empty            
            if !@editing_email.empty?
                @user.email = @editing_email.strip
                @profile_updates << "email"
            end

            #Change password if not empty            
            if !@editing_password.empty?
                @user.password = @editing_password.strip
                @profile_updates << "password"
            end

            #Save all changes to database
            @user.save

            #redirect user to player profile after editing
            erb :"/users/update_success"
        end
    end

    # DELETE USER ==> WHY CAN'T I MOVE THIS CODE UNDER MY USERS_CONTROLLER.RB??
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
            players = Player.all.map{|player| player.name.downcase}
            players.any?{|player| player == player_name}
        end

        def user_exists?(user_name)
            user = user_name.split.map(&:capitalize).join(' ').downcase.strip

            !!User.find_by_username(user)
        end

        def is_super_user?
            !!current_user.super_user == 1
        end

        #Test to see if name inputted is not the same as the current player.
        def edit_name_unique?(edit_name, current_name)

            edit_name == current_name
        end

    end

end