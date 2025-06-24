
class Collection < ApplicationRecord
  self.per_page = 40

  belongs_to :user
  belongs_to :card

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  after_create_commit :broadcast_to_owner

  def broadcast_to_owner
    broadcast_append_later_to(
      "cards_user_#{user_id}",
      target: "cards-grid",
      partial: "collections/collection",
      locals: { collection: self }
    )
  end

  def broadcast_remove_to_owner
    broadcast_remove_to(
      "cards",
      target: "cards-grid",
      pratial: "cards/card",
      locals: { card: self.card }
    )
  end
end
