class StaffController < ApplicationController
    get '/team/:slug/new_staff' do

        erb :"staff/new"
    end

    post '/team/:slug/staff' do
        binding.pry
    end
end