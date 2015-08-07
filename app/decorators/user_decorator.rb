class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def full_name
    object.first_name + ' ' + object.last_name
  end

  def human_started_at
    object.started_at.present? && object.started_at.strftime('%e %B %Y')
  end

  def in_project?(name)
    object.projects.find { |project| project.name == name.capitalize } if name.present?
  end
end

