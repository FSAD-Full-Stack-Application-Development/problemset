class CreatePs3Projects < ActiveRecord::Migration[7.1]
  def change
    create_table :ps3_projects do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
