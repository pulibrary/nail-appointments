class Availability < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :start_time_in_future

  private

  def start_time_before_end_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, 'must be before the end time')
    end
  end

  def start_time_in_future
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, 'must be in the future')
    end
  end
end
