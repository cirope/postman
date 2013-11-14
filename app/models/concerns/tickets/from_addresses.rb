module Tickets::FromAddresses
  extend ActiveSupport::Concern

  def is_from? email
    from.any? { |f| f.downcase == email.downcase }
  end

  def from_addresses
    from.join ', ' if from
  end

  def from_addresses=(addresses)
    self.from = addresses.split(/\s*,\s*/).map { |a| a.strip.downcase } if addresses
  end
end
