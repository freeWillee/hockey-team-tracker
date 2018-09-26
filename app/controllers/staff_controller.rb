class StaffController < ApplicationController
    # VISIT CREATE NEW STAFF FORM
    get '/team/:team_name/staff/new_staff' do
        @team = Team.find_by_name(session[:team_name])
        @salary_ranges = Salary.all            

        erb :"staff/new"
    end

    #VISIT STAFF PAGE
    get '/team/:team_name/staff/:staff_name' do
        if logged_in?
            @staff = Staff.find_by_slug(params[:staff_name])
                        
            erb :"staff/show"
        else
            redirect to '/login'
        end
    end
    
    # CREATE NEW STAFF MEMBER
    post '/team/:team_name/staff' do
        binding.pry

        @team = Team.find_by_name(session[:team_name])

        # Force user to enter at least a name on new staff form (reload new staff if name is blank)
        if params[:staff][:name].empty?
            redirect to "/team/#{@team.slug}/staff/new_staff"
        
        # Else as long as staff doesn't already exist, create staff and assign user inputted attributes
        elsif !staff_exists?(params[:staff][:name])
            @staff = Staff.create(params[:staff])
            #assign team to staff
            @staff.team = @team
            
            #assign position only if it doesn't already exist (use this code for editing player)
            @staff.role = params[:role]

            #save to database
            @staff.save

            #redirect user to player profile after creating
            redirect to "/team/#{@staff.team.slug}/staff/#{@staff.slug}"
        else
            #If user mistakenly adds a name that already exists, the user is directed to the staff's existing profile page.
            @staff = Staff.find_by_name(params[:staff][:name])
            redirect "/team/#{@team.slug}/staff/#{@staff.slug}"
        end
    end

    # VISIT EDIT STAFF PAGE
    get '/team/:team_slug/staff/:staff_slug/edit' do
        if logged_in?                
            @team = Team.find_by_name(session[:team_name])
            @salary_ranges = Salary.all
            @positions = Position.all
            @staff = Staff.find_by_slug(params[:staff_slug])
            
            erb :"staff/edit"
        else
            redirect to '/login'
        end
    end
end