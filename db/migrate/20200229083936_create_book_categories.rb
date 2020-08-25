class CreateBookCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_categories do |t|
      t.belongs_to :book, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
