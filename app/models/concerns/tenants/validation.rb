module Tenants::Validation
  extend ActiveSupport::Concern

  included do
    validates :name, :domain, :subdomain, presence: true, length: { maximum: 255 }
    validates :subdomain, format: { with: /\A[a-z\d]+(-[a-z\d]+)*\z/ }
    validates :domain, format: { with: /\A[a-z\d]+(-[a-z\d]+)*\.[a-z]{2,}(\.[a-z]{2,})*\z/ }
    validates :domain, :subdomain, uniqueness: { case_sensitive: false }
  end
end
