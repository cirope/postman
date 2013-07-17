module Tenants::Validation
  extend ActiveSupport::Concern

  included do
    validates :name, :subdomain, presence: true, length: { maximum: 255 }
    validates :subdomain, format: { with: /\A[a-z\d]+(-[a-z\d]+)*\z/ }
    validates :subdomain, uniqueness: { case_sensitive: false }
  end
end
