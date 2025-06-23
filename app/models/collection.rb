
class Collection < ApplicationRecord
  self.per_page = 96

  belongs_to :user
  belongs_to :card

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  def self.import(user_id, file)
  end
end
