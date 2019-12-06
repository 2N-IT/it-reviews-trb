class AddUserToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :created_by_user, foreign_key: { to_table: "users" }
  end
end
