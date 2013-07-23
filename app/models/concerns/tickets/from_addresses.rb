module Tickets::FromAddresses
  extend ActiveSupport::Concern

  def from_addresses
    from.join ', ' if from
  end

  def from_addresses=(addresses)
    self.from = addresses.split(/\s*,\s*/).map { |a| a.strip.downcase } if addresses
  end
end
