class AddUniqueConstraintToAvailabilityId < ActiveRecord::Migration[7.1]
  def up
    remove_index :appointments, :availability_id

    add_index :appointments, :availability_id, unique: true
  end

  def down
    remove_index :appointments, :availability_id
  end
end
