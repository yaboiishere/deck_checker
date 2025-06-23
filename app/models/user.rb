class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :collections, dependent: :destroy
  has_many :cards, through: :collections

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
