class AddCusomerInfoToTickets < ActiveRecord::Migration
  def up
    remove_index :tickets, column: :customer_id
    remove_column :tickets, :customer_id
    add_column :tickets, :customer_name, :string, null: false
    add_column :tickets, :customer_email, :string, null: false
  end

  def down
    add_column :tickets, :customer_id, :string, null: false
    add_index :tickets, :customer_id, name: :index_tickets_on_customer_id
    remove_column :tickets, :customer_name
    remove_column :tickets, :customer_email
  end
end
