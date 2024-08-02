class UpdateAvailabilitiesTableConstraints < ActiveRecord::Migration[7.1]
  def up
    change_column_default :availabilities, :filled_status, false
    change_column_null :availabilities, :filled_status, false

    change_column_null :availabilities, :start_time, false
    change_column_null :availabilities, :end_time, false
  end

  def down
    change_column_default :availabilities, :filled_status, nil
    change_column_null :availabilities, :filled_status, true

    change_column_null :availabilities, :start_time, true
    change_column_null :availabilities, :end_time, true
  end
end
