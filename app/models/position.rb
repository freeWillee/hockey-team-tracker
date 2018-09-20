class Position < ActiveRecord::Base
    has_many :player_positions
    has_many :players through: :player_positions
end