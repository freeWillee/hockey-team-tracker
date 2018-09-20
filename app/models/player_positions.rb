class PlayerPositions < ActiveRecord::Base
    belongs_to :player
    belongs_to :position

end