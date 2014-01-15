class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body, null: false, default: ''
      t.datetime :sent_at
      t.references :owner, polymorphic: true, index: true

      t.timestamps
    end
  end
end
