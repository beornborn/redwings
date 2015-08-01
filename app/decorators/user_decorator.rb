class UserDecorator < Draper::Decorator
  delegate_all

  decorates :user

  def name
    object.first_name + ' ' + object.last_name
  end

  def started_at
    object.started_at.present? && object.started_at.strftime('%e %B %Y')
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
