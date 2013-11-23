class CreateCreatives < ActiveRecord::Migration
  def change
    create_table :creatives do |t|
      t.string :title
      t.text :description
      t.integer :votes
      t.belongs_to :user

      t.timestamps
    end
  end
end
