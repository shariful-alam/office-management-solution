module ApplicationHelper
  def full_date(datetime)
    datetime.strftime('%d %B, %Y')
  end

  def full_date_with_time(datetime)
    datetime.strftime('%d %B, %Y at %I:%M%p')
  end

  def only_time(datetime)
    datetime.strftime('%I:%M%p')
  end

end
