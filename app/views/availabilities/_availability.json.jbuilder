# frozen_string_literal: true

json.extract! availability, :id, :start_time, :end_time, :filled_status, :created_at, :updated_at
json.url availability_url(availability, format: :json)
