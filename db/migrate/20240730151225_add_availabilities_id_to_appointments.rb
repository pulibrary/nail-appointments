class AddAvailabilitiesIdToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :availabilities_id, :bigint
    add_index :appointments, :availabilities_id
    add_foreign_key :appointments, :availabilities, column: :availabilities_id
  end
end
