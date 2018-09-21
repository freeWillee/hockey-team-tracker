class TeamController < ApplicationController
    get '/login' do

        erb :"/teams/login"
    end

    get '/signup' do
        
        erb :"/teams/signup"
    end
end