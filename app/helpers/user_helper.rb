module UserHelper
  def link_to_users(filter)
  	link = link_to filter.capitalize, users_path(filter: filter)
    current_page?(users_path(filter: filter)) ? content_tag(:li, link, class: 'active') : content_tag(:li, link)
  end
end

