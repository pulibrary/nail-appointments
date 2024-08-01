# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :availability

  validate :availability_start_time_in_future
  validates :availability_id, uniqueness: { message: 'is already taken' }

  after_save :update_availability_status

  private

  def availability_start_time_in_future
    if availability.present? && availability.start_time < Time.current
      errors.add(:availability, 'Must choose an appointment time in the future')
    end
  end

  def update_availability_status
    # Set filled_status to true for the associated availability
    availability.update(filled_status: true)
  end
end
