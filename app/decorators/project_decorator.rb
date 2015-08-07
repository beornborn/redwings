class ProjectDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def link_to_users
    link = link_to "#{object.name}", users_path(filter: object.name.downcase)
    current_page?(users_path(filter: project.name.downcase)) ? content_tag(:li, link, class: 'active') : content_tag(:li, link)
  end
end

