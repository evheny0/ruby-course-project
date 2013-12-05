class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :value, unique: true
      t.integer :ammount, :default => 1

      t.timestamps
    end
  end
end
