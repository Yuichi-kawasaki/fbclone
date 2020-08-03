class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :integer
  end
end
