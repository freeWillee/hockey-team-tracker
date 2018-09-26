class PlayersController < ApplicationController
    
    get '/team/:slug/new_player' do
        @team = Team.find_by_name(session[:team_name])
        @salary_ranges = Salary.all
        @positions = Position.all
        

        erb :"players/new"
    end
    
    post '/team/:slug/player' do        
        @team = Team.find_by_name(session[:team_name])
        binding.pry
        #find or create the player by name given
        @player = Player.find_or_create_by(name: params[:name])

        #assign team to player
        @player.team = @team

        #assign salary
        @player.salary = Salary.find_by_id(params[:salary_range].to_i)
        
        #assign position
        params[:positions].each do |position|
            binding.pry
            if !@player.positions.include? Position.find_by_id(position.to_i)
                @player.positions << Position.find_by_id(position.to_i)
            end
        end
        binding.pry
        @player.save
        binding.pry


        redirect to "/team/#{@player.team.slug}/#{@player.slug}"

    end

end