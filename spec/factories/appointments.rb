# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    service { 'Manicure' }
    comments { 'White French Tips' }
    association :user
    association :availability
  end
end
