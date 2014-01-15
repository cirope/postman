class Reply < ActiveRecord::Base
  include MessageOwner

  belongs_to :ticket

  def to_s
    body
  end
end
