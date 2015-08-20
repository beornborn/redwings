module AcademyHelper
  def expected_or_bad_progress(user)
    if academy_progress_good?(user)
      user.academy.expected_progress
    else
      user.academy.real_progress
    end
  end

  def expected_or_good_progress(user)
    if academy_progress_good?(user)
      user.academy.real_progress - user.academy.expected_progress
    else
      user.academy.expected_progress - user.academy.real_progress
    end
  end

  def academy_progress_good?(user)
    user.academy.progress_good?
  end

  def time_in_project(user)
    return false if user.started_at.nil? || user.finished_at.nil?

    time = user.finished_at - user.started_at
    months_count = (time / 1.month).to_i
    days_count = ((time % months_count.month) / 1.day).to_i

    if months_count == 0
      pluralize(days_count, 'day')
    elsif days_count == 0
      pluralize(months_count, 'month')
    else
      pluralize(months_count, 'month') + ' ' + pluralize(days_count, 'day')
    end
  end

  def time_interval_in_project(user)
    start  = user.started_at.present?  && user.started_at.strftime('%e %B %Y')
    finish = user.finished_at.present? && user.finished_at.strftime('%e %B %Y')
    start + ' - ' + finish
  end
end
