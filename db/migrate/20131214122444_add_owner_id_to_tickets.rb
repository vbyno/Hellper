class AddOwnerIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :owner, index: true, null: false
  end
end
