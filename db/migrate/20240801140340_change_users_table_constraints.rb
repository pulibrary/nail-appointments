class ChangeUsersTableConstraints < ActiveRecord::Migration[7.1]
  def up
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :pronouns, false
    change_column_null :users, :email, false
    change_column_null :users, :role, false

    add_index :users, :email, unique: true
  end

  def down
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
    change_column_null :users, :pronouns, true
    change_column_null :users, :email, true
    change_column_null :users, :role, true

    remove_index :users, :email
  end

end
