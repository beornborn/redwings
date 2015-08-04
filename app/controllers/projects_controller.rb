class ProjectsController < ApplicationController
  def update
    @project = Project.find_by(name: "Academy")
    @project.data = { 'total_task_time' => Service::Trello.total_tasks_time,
                      'time_for_project' => 30 * 24 * 60 * 60 }
    @project.save
  end
end
