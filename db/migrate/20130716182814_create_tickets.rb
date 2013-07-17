class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :from, array: true, null: false
      t.string :subject, null: false
      t.text :body

      t.timestamps
    end
  end
end
