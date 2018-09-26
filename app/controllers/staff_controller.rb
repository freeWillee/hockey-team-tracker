class StaffController < ApplicationController
    get '/team/:team_name/staff/:profile_slug' do
        if logged_in?
            @staff = Staff.find_by_slug(params[:profile_slug])
                        
            erb :"staff/show"
        else
            redirect to '/login'
        end
    end
    
    get '/team/:slug/new_staff' do

        erb :"staff/new"
    end

    post '/team/:slug/staff' do
        binding.pry
    end
end