class AddUserToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :creator, foreign_key: { to_table: "users" }
  end
end
