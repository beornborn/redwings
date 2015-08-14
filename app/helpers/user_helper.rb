module UserHelper
  def full_name(user)
    user.first_name + ' ' + user.last_name
  end

  def human_started_at(user)
    user.started_at.present? && user.started_at.strftime('%e %B %Y')
  end

  def email_with_logo(user)
    image_tag('email_logo.png') + ' ' +
    link_to(user.email, "mailto:#{user.email}") +
    content_tag(:span, '', class: "fa fa-clipboard clip_button",
                           id: "copy",
                           title: "Copy to clipboard",
                           data: { clipboard_text: ("#{user.email}"),
                                   toggle: "tooltip",
                                   placement: "right" })
  end

  def github_with_logo(user)
    unless user.github.blank?
      image_tag('github_logo.png') + ' ' +
      link_to(user.github, "https://github.com/#{user.github}") +
      content_tag(:span, '', class: "fa fa-clipboard clip_button",
                             id: "copy",
                             title: "Copy to clipboard",
                             data: { clipboard_text: ("#{user.github}"),
                                      toggle: "tooltip",
                                      placement: "right" })
    end
  end

  def username_with_logo(user)
    image_tag('slack_logo.png') + ' ' + user.username
  end

  def mobile_with_logo(user)
    image_tag('mobile_logo.png') + ' ' + user.mobile unless user.mobile.blank?
  end

  def skype_with_logo(user)
    unless user.skype.blank?
      image_tag('skype_logo.png') + ' ' +
      link_to(user.skype, "skype:#{user.skype}?chat") +
      content_tag(:span, '', class: "fa fa-clipboard clip_button",
                             id: "copy",
                             title: "Copy to clipboard",
                             data: { clipboard_text: ("#{user.skype}"),
                                     toggle: "tooltip",
                                     placement: "right" })
    end
  end

  def about_with_new_lines(user)
    text = "".html_safe
    splited = user.about.split("\n")
    splited.each{|x| text += content_tag(:p, x)}
    text
  end
end
