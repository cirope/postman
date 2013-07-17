class Tenant < ActiveRecord::Base
  include Tenants::Overrides
  include Tenants::Validation
end
