class Salary < ActiveRecord::Base
    has_many :staff
    has_many :players
end