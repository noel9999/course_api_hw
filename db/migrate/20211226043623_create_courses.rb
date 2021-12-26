class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :mentor_title
      t.text :description
      t.timestamps
    end
    add_index :courses, :title, unique: true
  end
end
