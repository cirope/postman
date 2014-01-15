class RemoveBodyFromTicketsAndReplies < ActiveRecord::Migration
  def change
    remove_column :tickets, :body
    remove_column :replies, :body
  end
end
