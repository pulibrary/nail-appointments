class Availability < ApplicationRecord
    has_many :appointments, dependent: :destroy
end
