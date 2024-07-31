class ChangeKeyColumnAppointments < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :appointments, column: :user_id
    remove_foreign_key :appointments, column: :availabilities_id
  end
  def down
    add_foreign_key :appointments, :users, column: :user_id
    add_foreign_key :appointments, :availabilities, column: :availabilities_id
  end
end
