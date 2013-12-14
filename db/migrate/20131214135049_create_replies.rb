class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body, null: false
      t.references :user, index: true, null: false
      t.references :ticket, index: true, null: false

      t.timestamps
    end
  end
end
