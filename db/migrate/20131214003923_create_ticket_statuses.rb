class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string :status, null: false

      t.timestamps
    end
  end
end
