class Ticket < ActiveRecord::Base
  include Tickets::FromAddresses
  include Tickets::MessageProcess
  include Tickets::Overrides
  include Tickets::Replies
  include Tickets::Status
  include Tickets::Subject
  include Tickets::Validation

  belongs_to :tenant
  belongs_to :category
  has_many :feedbacks, dependent: :destroy
end
