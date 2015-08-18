class Service::Academy
  def initialize(user)
    @user = user
  end

  def expected_progress
    percentage = ((Time.now - @user.started_at) / time_for_project).round(3) * 100
    [100, percentage].min
  end

  def real_progress
    percentage = (total_tasks_time == 0) ? 0 : (@user.spent_learn_time.to_f / total_tasks_time).round(3) * 100
    [100, percentage].min
  end

  def progress_good?
    expected_learn_time = expected_progress * total_tasks_time / 100
    expected_learn_time < @user.spent_learn_time
  end

  private

  def time_for_project
    Project.find_by(name: 'Academy')['data']['time_for_project']
  end

  def total_tasks_time
    total_tasks_time = Project.find_by(name: 'Academy')['data']['total_tasks_time']
    fail('Total tasks time is nil') if total_tasks_time.nil?
    total_tasks_time
  end
end
