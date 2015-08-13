class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    object.first_name + ' ' + object.last_name
  end

  def human_started_at
    object.started_at.present? && object.started_at.strftime('%e %B %Y')
  end

  def email_with_logo
    h.image_tag('email_logo.png') + ' ' + object.email
  end

  def github_with_logo
    h.image_tag('github_logo.png') + ' ' + object.github unless object.github.blank?
  end

  def username_with_logo
    h.image_tag('slack_logo.png') + ' ' + object.username
  end

  def mobile_with_logo
    h.image_tag('mobile_logo.png') + ' ' + object.mobile unless object.mobile.blank?
  end

  def skype_with_logo
    h.image_tag('skype_logo.png') + ' ' + object.skype unless object.skype.blank?
  end

  def about_with_new_lines
    text = "".html_safe
    splited = object.about.split("\n")
    splited.each{|x| text += h.content_tag(:p, x)}
    text
  end

  def expected_learn_time_progress_in_percent
    percentage = ((Time.now - object.started_at)/1.month).round(2)
    percentage = (percentage > 1) ? 1 : percentage
  end

  def spent_learn_time_progress_in_percent
    total_tasks_time = h.params[:total_tasks_time] || 1
    percentage = (total_tasks_time == 0) ? 0 : (object.spent_learn_time.to_f/total_tasks_time).round(2)
    percentage = (percentage > 1) ? 1 : percentage
  end

  def does_work_in_time?
    total_tasks_time = h.params[:total_tasks_time] || 1
    expected_learn_time = expected_learn_time_progress_in_percent * total_tasks_time
    return true unless object.spent_learn_time.present? && expected_learn_time > object.spent_learn_time
  end
end

