# frozen_string_literal: true

json.extract! appointment, :id, :service, :comments, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
