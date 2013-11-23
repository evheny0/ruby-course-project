class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :value
      t.integer :ammount

      t.timestamps
    end
  end
end
