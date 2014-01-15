class Message < ActiveRecord::Base
  validates :body, :owner, presence: true

  belongs_to :owner, polymorphic: true

  def to_s
    body
  end
end
