class AddCreativesNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :creatives_num, :integer, :default => 0
  end
end
