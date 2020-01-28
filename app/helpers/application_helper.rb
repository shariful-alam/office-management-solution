module ApplicationHelper
  def full_date(datetime)
    datetime.strftime('%d %B, %Y at %I:%M%p')
  end
end
