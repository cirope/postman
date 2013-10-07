class Feedback < ActiveRecord::Base
  SCORES = %w(great good poor)

  validates :from, :score, presence: true
  validates :from, uniqueness: { scope: :ticket_id }
  validates :score, inclusion: { in: SCORES }

  belongs_to :ticket

  def to_param
    from
  end
end
