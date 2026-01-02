class CreatePs3Students < ActiveRecord::Migration[7.1]
  def change
    create_table :ps3_students do |t|
      t.string :studentid
      t.string :name

      t.timestamps
    end
  end
end
