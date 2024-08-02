# frozen_string_literal: true

# spec/models/availability_spec.rb
require 'rails_helper'

RSpec.describe Availability do
  let(:valid_attributes) do
    {
      start_time: Date.tomorrow.beginning_of_day + 1.hour,
      end_time: Date.tomorrow.beginning_of_day + 2.hours,
      filled_status: false
    }
  end

  let(:availability) { described_class.create!(valid_attributes) }
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
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(availability).to be_valid
    end

    it 'is not valid without a start_time' do
      availability = described_class.new(valid_attributes.merge(start_time: nil))
      expect(availability).not_to be_valid
    end

    it 'is not valid without an end_time' do
      availability = described_class.new(valid_attributes.merge(end_time: nil))
      expect(availability).not_to be_valid
    end

    it 'is not valid with a start_time that is after the end_time' do
      availability = described_class.new(valid_attributes.merge(start_time: Date.tomorrow.beginning_of_day + 3.hours,
                                                                end_time: Date.tomorrow.beginning_of_day + 2.hours))
      expect(availability).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'destroys associated appointments when destroyed' do
      @appointment = Appointment.create!(user:, availability:, **appointment_attributes)
      expect { availability.destroy }.to change(Appointment, :count).by(-1)
    end
  end

  describe 'defaults' do
    it 'sets filled_status to false by default' do
      # Check that filled_status defaults to false
      expect(availability.filled_status).to be_falsey
    end
  end
end
