class User < ActiveRecord::Base
    has_secure_password
    belongs_to :team
    validates :username, :email, presence: true
    validates :username, uniqueness: {case_sensitive: false}

    def slug
        name = self.username
        slugged = name.downcase.gsub(" ", '-')
        slugged
    end

    def self.find_by_slug(slug)
        name = slug.split('-').join(" ")
        self.all.detect{|i| i.username.downcase == name}
    end
end
