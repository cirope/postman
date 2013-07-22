class AddCategoryToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :category, index: true
  end
end
