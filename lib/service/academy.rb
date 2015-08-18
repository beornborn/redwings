class Service::Academy
  def initialize(user)
    @user = user
    @academy = Project.find_by(name: 'Academy')
  end

  def expected_progress
    percentage = ((Time.now - @user.started_at) / time_for_project).round(3) * 100
    [100, percentage].min
  end

  def real_progress
    percentage = (@user.spent_learn_time.to_f / total_tasks_time).round(3) * 100
    [100, percentage].min
  end

  def progress_good?
    real_progress >= expected_progress
  end

  private

  def time_for_project
    @academy['data']['time_for_project']
  end

  def total_tasks_time
    @academy['data']['total_tasks_time']
  end
end
