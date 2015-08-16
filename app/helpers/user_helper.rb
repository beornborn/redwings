module UserHelper
  def full_name(user)
    user.first_name + ' ' + user.last_name
  end

  def human_started_at(user)
    user.started_at.present? && user.started_at.strftime('%e %B %Y')
  end

  def email_with_logo(user)
    image_tag('email_logo.png') + ' ' + user.email
  end

  def github_with_logo(user)
    image_tag('github_logo.png') + ' ' + user.github unless user.github.blank?
  end

  def username_with_logo(user)
    image_tag('slack_logo.png') + ' ' + user.username
  end

  def mobile_with_logo(user)
    image_tag('mobile_logo.png') + ' ' + user.mobile unless user.mobile.blank?
  end

  def skype_with_logo(user)
    image_tag('skype_logo.png') + ' ' + user.skype unless user.skype.blank?
  end

  def about_with_new_lines(user)
    text = "".html_safe
    splited = user.about.split("\n")
    splited.each{|x| text += content_tag(:p, x)}
    text
  end

  def expected_progress(user)
    Service::Academy.expected_progress(user)
  end

  def real_progress(user)
    Service::Academy.real_progress(user)
  end

  def progress_good?(user)
    Service::Academy.progress_good?(user)
  end
end
