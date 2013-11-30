class RenameVotesColunm < ActiveRecord::Migration
  def change
    change_table :creatives do |t|
      t.rename :votes, :num_of_votes
    end
  end
end
