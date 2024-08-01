class UpdateAppointmentsTable < ActiveRecord::Migration[7.1]
  def up
    change_column_null :appointments, :service, false
    change_column_null :appointments, :comments, false
    change_column_null :appointments, :user_id, false
    change_column_null :appointments, :availability_id, false
  end

  def down
    change_column_null :appointments, :service, true
    change_column_null :appointments, :comments, true
    change_column_null :appointments, :user_id, true
    change_column_null :appointments, :availability_id, true
  end

end
