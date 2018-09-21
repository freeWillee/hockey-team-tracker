class Player < ActiveRecord::Base
    has_many :player_positions
    has_many :positions, through: :player_positions
    belongs_to :team
    belongs_to :salary

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