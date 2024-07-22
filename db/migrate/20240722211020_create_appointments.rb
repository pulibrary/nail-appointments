class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.string :service
      t.string :comments

      t.timestamps
    end
  end
end
