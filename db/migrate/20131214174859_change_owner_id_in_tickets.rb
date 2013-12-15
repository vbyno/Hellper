class ChangeOwnerIdInTickets < ActiveRecord::Migration
  def up
    change_column :tickets, :owner_id, :integer, null: true
  end

  def down
    change_column :tickets, :owner_id, :integer, null: false
  end
end
