class SessionsController < ApplicationController
    #VISIT LOGIN PAGE
    get '/login' do
        if logged_in?
            @user = current_user
            redirect to "/team/#{@user.team.slug}"
        else
            erb :"/sessions/login"
        end
    end

    #LOGIN USER
    post '/sessions' do
        login(params[:username], params[:password])

        @user = current_user

        if @user && @user.super_user?
            redirect to "/admin"
        elsif @user
            redirect to "/team/#{@user.team.slug}"
        else
            @error_message = "User does not exist or incorrect password.  Please try again."
            erb :"sessions/login"
        end
    end
end