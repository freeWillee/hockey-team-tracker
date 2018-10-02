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
        @team = Team.find_by_name(current_user.team.name)
        
        if params[:salary][:new_amt].empty?
            @salary_input = params[:salary][:amount].to_i
        else
            @salary_input = params[:salary][:new_amt]
        end
        binding.pry
        # Force user to enter at least a name on new player form (reload new player if name is blank)
        if params[:name].empty?
            redirect to "/team/#{@team.slug}/player/new_player"
        
        # Else as long as player doesn't already exist, create player and assign user inputted attributes
        elsif !player_exists?(params[:name])
            @player = Player.new(name: params[:name])
            #assign details to player
            @player.teams << @team
            @player.birth_year = params[:birth_year].to_i
            @player.position = Position.find_by_id(params[:position].to_i)
            if @salary_input != nil
                @player.salary = Salary.find_or_create_by(amount: @salary_input)
            end
            binding.pry
            @player.GoalTarget = GoalTarget.find_or_create_by(target: params[:goals_target].to_i)
            @player.goals = params[:goals_to_date].to_i
            @player.AssistTarget = AssistTarget.find_or_create_by(target: params[:assists_target].to_i)
            @player.assists = params[:assists_to_date].to_i

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