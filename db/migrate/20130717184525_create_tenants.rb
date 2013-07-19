class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subdomain, null: false

      t.timestamps
    end

    add_index :tenants, :email, unique: true
    add_index :tenants, :subdomain, unique: true
  end
end
