module ApplicationHelper
  def full_date(datetime)
    datetime.strftime('%d %B, %Y at %I:%M %p')
  end

  def taka(amount)
    number_to_currency(amount, precision: 2,unit: " Taka",format: "%n %u")
  end
end
