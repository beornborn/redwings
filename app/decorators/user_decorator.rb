class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    object.first_name + ' ' + object.last_name
  end

  def human_started_at
    object.started_at.present? && object.started_at.strftime('%e %B %Y')
  end
end

