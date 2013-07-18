class Tenant < ActiveRecord::Base
  include Tenants::Overrides
  include Tenants::Validation

  has_many :tickets, dependent: :destroy
end
