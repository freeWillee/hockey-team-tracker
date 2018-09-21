class SessionsController < ApplicationController
    get '/login' do

        erb :"/sessions/login"
    end

    post '/sessions' do
        login(params[:team_name], params[:password])

        redirect to '/team'
    end

    
end