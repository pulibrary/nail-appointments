# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:valid_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: '123@default.com',
      password: '2394jfi',
      role: 'user'
    }
  end

  let(:invalid_attributes) do
    {
      first_name: 'Megan',
      last_name: 'Lai',
      pronouns: 'she/her',
      email: 'not-an-email',
      password: '2394jfi',
      role: 'invalid_role'
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = described_class.new(valid_attributes)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = described_class.new(valid_attributes.merge(email: nil))
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user = described_class.new(valid_attributes.merge(email: 'invalid-email'))
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      described_class.create!(valid_attributes)
      user = described_class.new(valid_attributes)
      expect(user).not_to be_valid
    end

    it 'raises an error with an invalid role' do
      expect do
        described_class.create!(valid_attributes.merge(role: 'invalid_role'))
      end.to raise_error(ArgumentError)
    end
  end

  describe 'callbacks' do
    it 'normalizes the email before saving' do
      user = described_class.create!(
        valid_attributes.merge(email: '  TEST@EMAIL.COM  ')
      )
      expect(user.email).to eq('test@email.com')
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
  end

  describe 'enums' do
    it 'defines roles enum with correct values' do
      expect(described_class.roles.keys).to match_array(%w[admin user])
    end

    it 'defaults to user role' do
      user = described_class.new(valid_attributes)
      expect(user.role).to eq('user')
    end

    it 'allows setting role to admin' do
      user = described_class.new(valid_attributes.merge(role: 'admin'))
      expect(user.role).to eq('admin')
    end
  end

  describe 'has_secure_password' do
    it 'authenticates with valid password' do
      user = described_class.create!(valid_attributes)
      expect(user.authenticate('2394jfi')).to eq(user)
    end

    it 'does not authenticate with invalid password' do
      user = described_class.create!(valid_attributes)
      expect(user.authenticate('wrong_password')).to be_falsey
    end
  end
end
