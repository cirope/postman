class Feedback < ActiveRecord::Base
  SCORES = %w(great good poor)

  validates :from, :score, presence: true
  validates :score, inclusion: { in: SCORES }

  belongs_to :ticket

  def to_param
    from
  end
end
