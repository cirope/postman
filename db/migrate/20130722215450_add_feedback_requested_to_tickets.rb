class AddFeedbackRequestedToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :feedback_requested, :boolean, null: false, default: false
  end
end
