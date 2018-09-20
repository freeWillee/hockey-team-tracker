class Staff < ActiveRecord::Base
    belongs_to :team
    belongs_to :salary
end