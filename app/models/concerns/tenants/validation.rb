module Tenants::Validation
  extend ActiveSupport::Concern

  included do
    validates :name, :email, :subdomain, presence: true, length: { maximum: 255 }
    validates :subdomain, format: { with: /\A[a-z\d]+(-[a-z\d]+)*\z/ }
    validates :email, format: { with: EMAIL_REGEX }
    validates :email, :subdomain, uniqueness: { case_sensitive: false }
  end
end
