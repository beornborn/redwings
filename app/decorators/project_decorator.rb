class ProjectDecorator < Draper::Decorator
  delegate_all

  def users_link_class
    h.current_page?(h.users_path(filter: project.name)) ? 'active' : ''
  end
end

