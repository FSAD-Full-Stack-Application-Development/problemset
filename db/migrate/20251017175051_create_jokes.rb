class CreateJokes < ActiveRecord::Migration[7.1]
  def change
    create_table :jokes do |t|
      t.string :author_name
      t.string :category
      t.text :quote

      t.timestamps
    end
  end
end
