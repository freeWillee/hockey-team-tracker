class UsersController < ApplicationController
    
    #VISIT CREATE-NEW-ADMIN PAGE
    get '/user/new-admin' do
        
        erb :"/users/new_super"
    end    

    #CREATE-NEW-ADMIN AND LOGIN
    post '/new-admin' do
        @user = User.new(params[:user])
        @user.super_user = 1
        
        binding.pry
        @user.save

        session[:username] = @user.username
        
        redirect to "/admin"
    end

    #LOGIN AS ADMIN
    get '/admin' do
        if logged_in?
            @user = current_user
            @all_users = User.all.map{|user| user.super_user == 0}
            binding.pry
            erb :"/users/show_super"
        else
            @message = "You have not logged in.  Please log in below"
            erb :"/sessions/login"
        end
    end

    #VISIT CREATE-NEW-USER PAGE
    get '/user/new-user' do
        @user = current_user
        
        erb :"/users/new_user"
    end

    #CREATE USER (READ-ONLY)
    post '/new-user' do
        @user = User.new(params[:user])
        if @user.valid?
            @user.super_user = 0
            @user.team = current_user.team
            binding.pry
            @user.save

            redirect to "/admin"
        else
            @user.valid?

            erb :"users/new_user"
        end
    end
end