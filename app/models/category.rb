class Category < ActiveRecord::Base
  include Attributes::Strip

  strip_fields :name

  validates :name, presence: true, length: { maximum: 255 },
    uniqueness: { case_sensitive: false }

  has_many :tickets

  def to_s
    name
  end
end
