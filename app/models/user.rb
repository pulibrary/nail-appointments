require 'bcrypt'

class User < ApplicationRecord
    has_many :appointments, dependent: :destroy

    before_save :normalize_email
    has_secure_password
    
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true

    private
    def normalize_email
        self.email = email.strip.downcase
    end
end

