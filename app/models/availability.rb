# frozen_string_literal: true

class Availability < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :start_time_in_future

  private

  def start_time_before_end_time
    return unless start_time.present? && end_time.present? && start_time >= end_time

    errors.add(:start_time, 'must be before the end time')
  end

  def start_time_in_future
    return unless start_time.present? && start_time < Time.current

    errors.add(:start_time, 'must be in the future')
  end
end
