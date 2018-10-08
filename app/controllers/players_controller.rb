class PlayersController < ApplicationController
    
    #VISIT CREATE NEW PLAYER
    get '/team/:team_name/player/new_player' do
        if logged_in?
            @team = Team.find_by_name(current_user.team.name)
            @salary = Salary.all
            @positions = Position.all
            
            erb :"players/new"
        else
            redirect to '/login'
        end
    end

    #VISIT PLAYER PAGE
    get '/team/:team_name/player/:player_name' do
        if logged_in?
            @user = current_user
            @player = Player.find_by_slug(params[:player_name])

            erb :"players/show"
        else
            redirect to '/login'
        end
    end
    
    #POST TO CREATE NEW PLAYER
    post '/team/:team_name/player' do
        # INSTANCE VARIABLE DEFINITIONS
        @team = Team.find_by_name(current_user.team.name)
        
        #If new salary is inputted, ignore radio buttons clicked
        
        #Edge case definition for salary input (if selected other and nothing inputted, redirect back to new_player screen)
        if params[:salary][:new_amt].empty? && params[:salary][:amount] == "nil"
            redirect to "/team/#{@team.slug}/player/new_player"
        elsif params[:salary][:new_amt].empty?
            @salary_input = params[:salary][:amount].to_i
        else
            @salary_input = params[:salary][:new_amt]
        end

        @goals_target = GoalTarget.find_or_create_by(target: params[:goals_target].to_i) if params[:goals_target] != ""
        @assists_target = AssistTarget.find_or_create_by(target: params[:assists_target].to_i) if params[:assists_target] != ""
        @goals = params[:goals_to_date].to_i
        @assists = params[:assists_to_date].to_i

        # Force user to enter at least a name on new player form (reload new player if name is blank)
        if params[:name].empty?
            redirect to "/team/#{@team.slug}/player/new_player"
        
        # Else as long as player doesn't already exist, create player and assign user inputted attributes
        elsif !player_exists?(params[:name])
            #Assign basic player details
            @player = Player.new(name: params[:name])
            @player.teams << @team
            @player.birth_year = params[:birth_year].to_i
            @player.position = Position.find_by_id(params[:position].to_i)

            #Assign salary 
            if @salary_input != nil
                @player.salary = Salary.find_or_create_by(amount: @salary_input)
            end

            #Assign Goal target
            @player.GoalTarget = @goals_target if @goals_target != nil

            @player.AssistTarget = @assists_target if @assists_target != nil

            @player.goals = @goals if @goals != 0

            @player.assists = @assists if @assists != 0

            #save to database
            @player.save

            #redirect user to player profile after creating
            redirect to "/team/#{@team.slug}/player/#{@player.slug}"
        else
            #If user mistakenly adds a name that already exists, the user is directed to the player's existing profile page.
            @player = Player.find_by_name(params[:player][:name])
            redirect "/team/#{@team.slug}/player/#{@player.slug}"
        end
    end

    # VISIT EDIT PLAYER PAGE
    get '/team/:team_slug/player/:player_slug/edit' do
        if logged_in? && current_user.super_user?            
            @team = Team.find_by_name(current_user.team.name)
            @salary = Salary.all
            @positions = Position.all
            @player = Player.find_by_slug(params[:player_slug])
            
            erb :"players/edit"
        else
            redirect to '/login'
        end
    end
end