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

    # EDIT STAFF ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    patch '/team/:team_slug/staff/:staff_slug' do

        @team = Team.find_by_name(session[:team_name])
        @staff = Staff.find_by_slug(params[:staff_slug])
        @editing_staff_name = params[:staff][:name]
        @editing_role = params[:role]
        @salary_range_selected = Salary.find_by_id(params[:staff][:salary_id].to_i)

        if staff_exists?(@editing_staff_name) && @editing_staff_name != @staff.name
            #RAISE MESSAGE ERROR THAT STAFF ALREADY EXISTS
            existing_staff = Staff.find_by_name(@editing_staff_name)

            redirect to "/team/#{params[:team_slug]}/staff/#{existing_staff.slug}"
        else
            #Change name if not empty            
            if !@editing_staff_name.empty?
                @staff.name = @editing_staff_name
            end

           #Change role if not empty            
            if !@editing_role.empty?
                    @staff.role = @editing_role
            end
    
            #Update salary range if necessary
            @staff.salary = @salary_range_selected if @staff.salary != @salary_range_selected

            #Save all changes to database
            @staff.save

            #redirect user to player profile after creating
            redirect to "/team/#{@staff.team.slug}/staff/#{@staff.slug}"            
        end
    end

    # DELETE STAFF ==> WHY CAN'T I MOVE THIS CODE UNDER MY PLAYERS_CONTROLLER.RB??
    delete '/team/:team_slug/staff/:staff/delete' do
        @staff = Staff.find_by_slug(params[:staff])
        @staff.delete

        erb :"staff/delete"
    end

    #HELPER METHODS
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

        def staff_exists?(staff_name)
            !!Staff.find_by_name(staff_name)
        end
    end

end