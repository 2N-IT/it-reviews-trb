class AddActiveToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :active, :boolean, default: false
    add_column :users, :activation_token, :string
    add_index  :users, :activation_token, unique: true
  end
end
