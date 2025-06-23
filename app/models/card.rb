class Card < ApplicationRecord
  self.per_page = 96

  validates :name, presence: true
  validates :collector_number, presence: true
  validates :foil, inclusion: { in: [ true, false ] }
  validates :altered, inclusion: { in: [ true, false ] }
  validates :misprint, inclusion: { in: [ true, false ] }
  validates :condition, presence: true, inclusion: { in: %w[near_mint lightly_played moderately_played heavily_played damaged] }
  # validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :scryfall_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :rarity, presence: true, inclusion: { in: %w[common uncommon rare mythic] }
  validates :mtg_set_id, presence: true
  validates :language_id, presence: true
  validates :currency_id, presence: true
  validates :name, uniqueness: { scope: [ :mtg_set_id, :collector_number, :language_id, :condition, :foil, :altered, :misprint ] }

  belongs_to :language
  belongs_to :currency
  belongs_to :mtg_set

  has_many :collections, dependent: :destroy

  CONSTRAINT_ERROR=
    "already exists with the same name, set, collector number, language, condition, foil status, altered status, and misprint status"
  validates_uniqueness_of(:name, scope: [  :mtg_set_id, :collector_number, :language_id, :condition, :foil, :altered, :misprint ],
    message: CONSTRAINT_ERROR)
end
