class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body, null: false
      t.references :ticket, null: false, index: true

      t.timestamps
    end
  end
end
