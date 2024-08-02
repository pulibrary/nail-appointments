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
      start_time: Date.tomorrow.beginning_of_day + 1.hour,
      end_time: Date.tomorrow.beginning_of_day + 2.hours
    }
  end

  let(:user) { User.create!(user_attributes) }
  let(:availability) { Availability.create!(availability_attributes.merge(filled_status: false)) }

  let(:valid_attributes) do
    {
      user:,
      availability:,
      service: 'Mani',
      comments: 'White Tips'
    }
  end

  let(:future_availability) do
    Availability.create!(start_time: 1.hour.from_now, end_time: 2.hours.from_now)
  end

  let(:past_availability) do
    Availability.create!(start_time: 2.hours.ago, end_time: 1.hour.ago)
  end

  before do
    # Temporarily disable the future validation for this test
    Availability.class_eval do
      def start_time_in_future; end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:availability) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      appointment = described_class.new(valid_attributes)
      expect(appointment).to be_valid
    end

    it 'is not valid without a user' do
      appointment = described_class.new(valid_attributes.merge(user: nil))
      expect(appointment).not_to be_valid
    end

    it 'is not valid without an availability' do
      appointment = described_class.new(valid_attributes.merge(availability: nil))
      expect(appointment).not_to be_valid
    end

    it 'is valid with a future availability' do
      appointment = described_class.new(user:, availability: future_availability)
      expect(appointment).to be_valid
    end

    it 'is not valid with a past availability' do
      appointment = described_class.new(user:, availability: past_availability)
      expect(appointment).not_to be_valid
      expect(appointment.errors[:availability]).to include('Must choose an appointment time in the future')
    end
  end

  describe 'callbacks' do
    context 'when an appointment is created' do
      it 'updates the filled_status of the associated availability to true' do
        described_class.create!(valid_attributes)

        # Reload the availability to get the updated status
        expect(availability.reload.filled_status).to be_truthy
      end
    end
  end
end
