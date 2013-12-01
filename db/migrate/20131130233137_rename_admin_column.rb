class RenameAdminColumn < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :admin?, :admin
    end
  end
end
