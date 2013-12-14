class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :customer, index: true
      t.references :ticket_subject, index: true
      t.references :ticket_status, index: true
      t.string :reference, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
