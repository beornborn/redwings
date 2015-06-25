class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true, uniqueness: true

  validates :password, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
end

