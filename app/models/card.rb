class Card < ApplicationRecord
  self.per_page = 96

  belongs_to :language
  belongs_to :currency
  belongs_to :mtg_set

  CONSTRAINT_ERROR=
    "already exists with the same name, set, collector number, language, condition, foil status, altered status, and misprint status"
  validates_uniqueness_of(:name, scope: [  :mtg_set_id, :collector_number, :language_id, :condition, :foil, :altered, :misprint ],
    message: CONSTRAINT_ERROR)
end
