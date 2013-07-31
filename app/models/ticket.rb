class Ticket < ActiveRecord::Base
  include Tickets::Feedback
  include Tickets::FromAddresses
  include Tickets::MessageProcess
  include Tickets::Overrides
  include Tickets::Replies
  include Tickets::Scopes
  include Tickets::Status
  include Tickets::Subject
  include Tickets::Validation

  belongs_to :tenant
  belongs_to :category
  belongs_to :user
end
