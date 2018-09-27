class UsersController < ApplicationController
    get '/user/new-admin' do
        
        erb :"/users/new_super"
    end    

    post '/new-admin' do
        @user = User.new(params[:user])
        @user.super_user = 1
        session[:username] = @user.username
        @user.save
        
        redirect to "/admin"
    end

    get '/admin' do
        if logged_in?
            @user = current_user
            @all_users = User.all.detect{|user| user.super_user == 0}
            
            erb :"/users/show_super"
        else
            redirect to "/login"
        end
    end


    post '/new-user' do
        binding.pry
        @user = User.new(params[:user])
        @user.super_user = 0
        @user.save

        erb :"/user/show_super"
    end
end