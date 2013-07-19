class Tenant < ActiveRecord::Base
  include Attributes::Strip
  include Attributes::Downcase
  include Tenants::Overrides
  include Tenants::Validation

  strip_fields :email, :subdomain
  downcase_fields :email, :subdomain

  has_many :tickets, dependent: :destroy
end
