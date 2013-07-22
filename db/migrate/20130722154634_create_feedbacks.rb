class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :from, null: false
      t.string :score, null: false
      t.text :notes
      t.references :ticket, index: true

      t.timestamps
    end
  end
end
