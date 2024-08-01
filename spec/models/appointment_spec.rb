# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment do
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

  let(:availability_attributes) do
    {
      start_time: Date.today.beginning_of_day + 1.hour,
      end_time: Date.today.beginning_of_day + 2.hours
    }
  end

  let(:user) { User.create!(user_attributes) }
  let(:availability) { Availability.create!(availability_attributes.merge(filled_status: false)) }
  
  let(:valid_attributes) do
    {
      user: user,
      availability: availability
    }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:availability) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      appointment = Appointment.new(valid_attributes)
      expect(appointment).to be_valid
    end

    it 'is not valid without a user' do
      appointment = Appointment.new(valid_attributes.merge(user: nil))
      expect(appointment).to_not be_valid
    end

    it 'is not valid without an availability' do
      appointment = Appointment.new(valid_attributes.merge(availability: nil))
      expect(appointment).to_not be_valid
    end
  end
end
