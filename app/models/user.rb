require 'bcrypt'

class User < ApplicationRecord
    ## users.password_hash in the database is a :string
    include BCrypt    
    before_save :normalize_email

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
    
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true

    private
    def normalize_email
        self.email = email.strip.downcase
    end
end

