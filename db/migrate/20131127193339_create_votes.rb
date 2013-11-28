class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :creative

      t.timestamps
    end
  end
end
