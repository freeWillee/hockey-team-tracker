class Team < ActiveRecord::Base
    has_many :player_teams
    has_many :players, through: :player_teams
    has_many :users

    def slug
        name = self.name
        slugged = name.downcase.gsub(" ", '-')
        slugged
    end

    def self.find_by_slug(slug)
        name = slug.split('-').join(" ")
        self.all.detect{|i| i.name.downcase == name}
    end
    
    
end