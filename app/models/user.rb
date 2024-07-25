# frozen_string_literal: true

require 'bcrypt'

class User < ApplicationRecord
  has_many :appointments, dependent: :destroy

    before_save :normalize_email
    has_secure_password
    
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true

    # makes sure role can only be admin or user
    enum role: { admin: 'admin', user: 'user' }
    validates :role, inclusion: { in: roles.keys }

  private

  def normalize_email
    self.email = email.strip.downcase
  end
end
