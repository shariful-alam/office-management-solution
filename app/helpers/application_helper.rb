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

  def taka(amount)
    number_to_currency(amount, precision: 2, unit: " Taka", format: "%n %u")
  end

  def conversion(string)
    string.singularize()
    string.pluralize()
  end

  def budget_hint
    date = Date.today
    month=date.strftime("%B")+', '+date.strftime("%Y")
    present_budget=Budget.find_by(month: month)

    "<h6> Budget for <strong>  #{present_budget.month}  </strong> </h6>
     <strong> Total :   #{taka(present_budget.amount)} </strong>
     <strong> Expense :   #{taka(present_budget.expense)}  </strong>
     <strong> Remaining :  #{taka(present_budget.amount- present_budget.expense)}  </strong>".html_safe
  end

  def see_pending_request
    pending=Expense.where(status: 'Pending').count + Leafe.where(status: 'Pending').count
    return pending
  end



end

