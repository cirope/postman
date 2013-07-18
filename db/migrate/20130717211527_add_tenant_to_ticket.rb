class AddTenantToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :tenant, null: false, index: true
  end
end
