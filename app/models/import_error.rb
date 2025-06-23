class ImportError < ApplicationRecord
  validates :user_id, presence: true
  validates :file_name, presence: true
  validates :error_message, presence: true
end
