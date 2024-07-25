class AddUserIdToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :user_id, :bigint
    add_index :appointments, :user_id
    add_foreign_key :appointments, :users, column: :user_id
  end
end
