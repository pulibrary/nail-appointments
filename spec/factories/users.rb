# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Megan' }
    last_name { 'Lai' }
    pronouns { 'she/her' }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { '2394jfi' }
    role { 'user' }
  
    factory :admin do
      role { 'admin' }
    end
  end
end