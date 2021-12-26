class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.belongs_to :chapter, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.text :content
      t.integer :order, default: 0
      t.timestamps
    end
  end
end
