# spec/models/availability_spec.rb
require 'rails_helper'

RSpec.describe Availability, type: :model do
  let(:valid_attributes) do
    {
      start_time: Date.today.beginning_of_day + 1.hour,
      end_time: Date.today.beginning_of_day + 2.hours,
      filled_status: false
    }
  end

  let(:availability) { Availability.create!(valid_attributes) }
  let(:user_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: '123@default.com',
      password: '2394jfi',
      role: 'admin'
    }
  end
  
  let(:user) { User.create!(user_attributes) }

  let(:appointment_attributes) do
    {
      service: 'Manicure',
      comments: 'White tips'
    }
  end

  describe 'associations' do
    it { should have_many(:appointments).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(availability).to be_valid
    end

    it 'is not valid without a start_time' do
      availability = Availability.new(valid_attributes.merge(start_time: nil))
      expect(availability).to_not be_valid
    end

    it 'is not valid without an end_time' do
      availability = Availability.new(valid_attributes.merge(end_time: nil))
      expect(availability).to_not be_valid
    end

    it 'is not valid with a start_time that is after the end_time' do
      availability = Availability.new(valid_attributes.merge(start_time: Date.today.beginning_of_day + 3.hours, end_time: Date.today.beginning_of_day + 2.hours))
      expect(availability).to_not be_valid
    end
  end

  describe 'callbacks' do
    it 'destroys associated appointments when destroyed' do
      @appointment = Appointment.create!(user: user, availability: availability, **appointment_attributes)
      expect { availability.destroy }.to change(Appointment, :count).by(-1)
    end
  end
end