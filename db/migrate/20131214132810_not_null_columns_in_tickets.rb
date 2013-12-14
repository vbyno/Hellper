class NotNullColumnsInTickets < ActiveRecord::Migration
  def up
    [:customer_id, :ticket_subject_id, :ticket_status_id].each do |column_name|
      change_column :tickets, column_name, :integer, null: false
    end
  end

  def down
    [:customer_id, :ticket_subject_id, :ticket_status_id].each do |column_name|
      change_column :tickets, column_name, :integer
    end
  end
end
