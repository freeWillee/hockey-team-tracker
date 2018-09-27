class SessionsController < ApplicationController
    get '/login' do

        erb :"/sessions/login"
    end

    post '/sessions' do
        login(params[:username], params[:password])
        @user = User.find_by(:username => params[:username])

        if @user.team == nil
            redirect to "/admin"
        else
            redirect to "/team/#{@user.team.slug}"
        end
    end

    
end