module UserHelper
  def academy_users_count
    Project.find_by(name: 'Academy').users.deleted(false).count
  end

  def redwings_users_count
    Project.find_by(name: 'Redwings').users.deleted(false).count
  end
end

