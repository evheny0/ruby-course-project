class CreateCreativesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :creatives_tags, id: false do |t|
      t.integer :creative_id
      t.integer :tag_id
    end
    add_index :creatives_tags, [:creative_id, :tag_id]
  end
end
