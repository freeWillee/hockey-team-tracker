class UsersController < ApplicationController
    
    #VISIT CREATE-NEW-ADMIN PAGE
    get '/user/new-admin' do
        if logged_in? && current_user.super_user?
            redirect to "/admin"
        elsif logged_in? && !current_user.super_user?
            redirect to "/team/#{current_user.team.slug}"
        else
            @user = current_user
            erb :"/users/new_super"
        end
    end    

    #CREATE-NEW-ADMIN AND LOGIN
    post '/new-admin' do
        @user = User.new(params[:user])
        binding.pry
        if @user.valid?
            @user.super_user = 1
            @user.save
            binding.pry
            session[:username] = @user.username

            redirect to "/admin"
        else
            @user.valid?

            erb :"users/new_super"
        end
    end

    #LOGIN AS ADMIN
    get '/admin' do
        if logged_in?
            @user = current_user
            @all_users = User.all.map{|user| user if user.super_user == 0}.compact

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

            @user.save

            redirect to "/admin"
        else
            @user.valid?

            erb :"users/new_user"
        end
    end

    #VIST USER (READ-ONLY) PAGE
    get '/user/:user_slug' do
        if logged_in?
            @logged_in_user = current_user
            @selected_user = User.find_by_slug(params[:user_slug])

            erb :"users/show_user"
        else
            redirect to '/login'
        end
    end
end