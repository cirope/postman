class Reply < ActiveRecord::Base
  include MessageOwner

  validates :body, presence: true

  belongs_to :ticket

  def to_s
    body
  end
end
