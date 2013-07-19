class Reply < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :ticket
end
