class Player < ActiveRecord::Base
    has_many :player_teams
    has_many :teams, through: :player_teams
    belongs_to :GoalTarget
    belongs_to :AssistTarget
    belongs_to :position
    belongs_to :salary
    validates :name, uniqueness: {case_sensitive: false}

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