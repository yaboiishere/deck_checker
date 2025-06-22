password_digest = BCrypt::Password.create("password")
FactoryBot.define do
  factory :user do
    email_address { "test@test.com" }
    password_digest { password_digest }
  end
end
