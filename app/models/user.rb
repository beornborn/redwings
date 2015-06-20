class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :name,     presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,    presence: true
end

