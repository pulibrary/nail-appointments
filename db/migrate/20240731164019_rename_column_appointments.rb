class RenameColumnAppointments < ActiveRecord::Migration[7.1]
  def up
    rename_column :appointments, :availabilities_id, :availability_id
  end

  def down
    rename_column :appointments, :availability_id, :availabilities_id
  end
end
