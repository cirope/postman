class Message < ActiveRecord::Base
  validates :owner, presence: true

  belongs_to :owner, polymorphic: true

  def to_s
    body
  end
end
