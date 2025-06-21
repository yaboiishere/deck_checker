class Language < ApplicationRecord
  has_many :cards, dependent: :nullify
end
