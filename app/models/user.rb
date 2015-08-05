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

  scope :not_admins, -> { where(admin: false).order(started_at: :desc) }
  scope :deleted, -> (deleted) { not_admins.where(deleted: deleted) }

  def self.by_project(project_name, user)
    Project.find_by(name: project_name).users.where.not(id: user.id).deleted(false).decorate
  end

  def self.disabled
    User.deleted(true).decorate
  end

  private

  def user_correction
    self.username =   (/[a-z]*\.[a-z]*/ =~ self.username) ? self.username : "#{self.username}.#{self.username}"
    self.first_name = 'Noname' if self.first_name.blank?
    self.last_name =  'Noname' if self.last_name.blank?
  end

end

