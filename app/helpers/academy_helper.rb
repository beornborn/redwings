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
end
