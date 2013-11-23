class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :content
      t.integer :order
      t.belongs_to :creative

      t.timestamps
    end
  end
end
