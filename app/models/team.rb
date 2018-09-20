class Team < ActiveRecord::Base
    has_secure_password
    has_many :players
    has_many :staff
    
    
end