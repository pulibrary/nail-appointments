# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AppointmentsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/appointments').to route_to(
        controller: 'appointments',
        action: 'index',
        user_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/users/1/appointments/new').to route_to(
        controller: 'appointments',
        action: 'new',
        user_id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/users/1/appointments/1').to route_to(
        controller: 'appointments',
        action: 'show',
        user_id: '1',
        id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: 'users/1/appointments/1/edit').to route_to(
        controller: 'appointments',
        action: 'edit',
        user_id: '1',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/users/1/appointments').to route_to(
        controller: 'appointments',
        action: 'create',
        user_id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/1/appointments/1').to route_to(
        controller: 'appointments',
        action: 'update',
        user_id: '1',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/1/appointments/1').to route_to(
        controller: 'appointments',
        action: 'update',
        user_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/appointments/1').to route_to(
        controller: 'appointments',
        action: 'destroy',
        user_id: '1',
        id: '1'
      )
    end

    it 'routes to #all' do
      expect(get: '/appointments/all').to route_to('appointments#all')
    end
  end
end
