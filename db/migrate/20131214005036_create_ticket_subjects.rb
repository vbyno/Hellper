class CreateTicketSubjects < ActiveRecord::Migration
  def change
    create_table :ticket_subjects do |t|
      t.string :subject, null: false

      t.timestamps
    end
  end
end
