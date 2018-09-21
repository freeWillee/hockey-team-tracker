class StaffController < ApplicationController
    get '/team/:team_name/:staff_slug' do
        @staff = Staff.find_by_slug(params[:staff_slug])
        
        erb :"staff/show"
    end
end