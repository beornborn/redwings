module Service
  class Academy
    def self.expected_progress(user)
      percentage = ((Time.now - user.started_at)/1.month).round(2)
      percentage = (percentage > 1) ? 1 : percentage
    end

    def self.real_progress(user)
      total_tasks_time = Project.find_by(name: 'Academy').data['total_tasks_time']
      fail('Total tasks time is nil') if total_tasks_time.nil?

      percentage = (total_tasks_time == 0) ? 0 : (user.spent_learn_time.to_f/total_tasks_time).round(2)
      percentage = (percentage > 1) ? 1 : percentage
    end

    def self.progress_good?(user)
      total_tasks_time = Project.find_by(name: 'Academy').data['total_tasks_time']
      fail('Total tasks time is nil') if total_tasks_time.nil?

      expected_learn_time = expected_progress(user) * total_tasks_time
      expected_learn_time > user.spent_learn_time
    end
  end
end
