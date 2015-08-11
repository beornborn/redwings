class User < ActiveRecord::Base
  has_many :projects_users
  has_many :projects, through: :projects_users

  before_validation :user_correction

  authenticates_with_sorcery!

  attr_accessor :do_password_validation

  validates :username,   presence: true, length: { maximum: 50 }, format: { with: /[a-z]*\.[a-z]*/ }
  validates :first_name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :last_name,  presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z]/ }
  validates :email,      presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }, if: :do_password_validation
  validates :password_confirmation, presence: true, if: :do_password_validation
  validates :about,      length: { minimum: 600, maximum: 1000 }

  scope :active, -> { where deleted: false }
  scope :disabled, -> { where deleted: true }
  scope :by_project, -> (name) { joins(:projects).merge(Project.by_name name) }

  private

  def user_correction
    self.username =   (/[a-z]*\.[a-z]*/ =~ self.username) ? self.username : "#{self.username}.#{self.username}"
    self.first_name = 'Noname' if self.first_name.blank?
    self.last_name =  'Noname' if self.last_name.blank?
  end
end
