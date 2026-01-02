class CreatePs3ProjectStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :ps3_project_students do |t|
      t.references :ps3_project, null: false, foreign_key: true
      t.references :ps3_student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
