class PlayersController < ApplicationController
    
    #VISIT CREATE NEW PLAYER
    get '/team/:team_name/player/new_player' do
        @team = Team.find_by_name(session[:team_name])
        @salary_ranges = Salary.all
        @positions = Position.all
        
        erb :"players/new"
    end

    #VISIT PLAYER PAGE
    get '/team/:team_name/player/:profile_slug' do
        if logged_in?
            @player = Player.find_by_slug(params[:profile_slug])
            erb :"players/show"
        else
            redirect to '/login'
        end
    end
    
    #POST TO CREATE NEW PLAYER
    post '/team/:slug/player' do        
        @team = Team.find_by_name(session[:team_name])

        # Force user to enter at least a name on new player form (reload new player if name is blank)
        if params[:player][:name].empty?
            redirect to "/team/#{@team.slug}/player/new_player"
        
        # Else as long as player doesn't already exist, create player and assign user inputted attributes
        elsif !player_exists?(params[:player][:name])
            @player = Player.create(params[:player])
            #assign team to player
            @player.team = @team
            
            #assign position only if it doesn't already exist (use this code for editing player)
            params[:positions].each do |position|
                if !@player.positions.include? Position.find_by_id(position.to_i)
                    @player.positions << Position.find_by_id(position.to_i)
                end
            end

            #save to database
            @player.save

            #redirect user to player profile after creating
            redirect to "/team/#{@player.team.slug}/player/#{@player.slug}"
        else
            #If user mistakenly adds a name that already exists, the user is directed to the player's existing profile page.
            @player = Player.find_by_name(params[:player][:name])
            redirect "/team/#{@team.slug}/player/#{@player.slug}"
        end
    end

    # VISIT EDIT PLAYER PAGE
    get '/team/:team_slug/player/:player_slug/edit' do

        @team = Team.find_by_name(session[:team_name])
        @salary_ranges = Salary.all
        @positions = Position.all
        @player = Player.find_by_slug(params[:player_slug])
        
        erb :"players/edit"
    end

    


end