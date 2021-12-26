class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.belongs_to :course, index: true, foreign_key: true
      t.string :title
      t.integer :order, default: 0
      t.timestamps
    end
  end
end
