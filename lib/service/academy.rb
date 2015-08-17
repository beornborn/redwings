module Service
  class Academy
    def self.expected_progress(user)
      time_for_project = Project.find_by(name: 'Academy').data['time_for_project']
      fail('Time for project is nil') if time_for_project.nil?

      percentage = ((Time.now - user.started_at)/time_for_project).round(3)
      percentage = (percentage > 1) ? 100 : percentage * 100
    end

    def self.real_progress(user)
      total_tasks_time = Project.find_by(name: 'Academy').data['total_tasks_time']
      fail('Total tasks time is nil') if total_tasks_time.nil?

      percentage = (total_tasks_time == 0) ? 0 : (user.spent_learn_time.to_f/total_tasks_time).round(3)
      percentage = (percentage > 1) ? 100 : percentage * 100
    end

    def self.progress_good?(user)
      total_tasks_time = Project.find_by(name: 'Academy').data['total_tasks_time']
      fail('Total tasks time is nil') if total_tasks_time.nil?

      expected_learn_time = expected_progress(user) * total_tasks_time / 100
      expected_learn_time < user.spent_learn_time
    end
  end
end
