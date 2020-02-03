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
    month = date.strftime("%B")+', '+date.strftime("%Y")
    present_budget=Budget.find_by(month: month)
    if present_budget == nil
      "<strong> The budget is not added yet !</strong>".html_safe
    else
      "<h6> Budget for <strong>  #{present_budget.month}  </strong> </h6>
     <strong> Total :   #{taka(present_budget.amount)} </strong>
     <strong> Expense :   #{taka(present_budget.expense)}  </strong>
     <strong> Remaining :  #{taka(present_budget.amount- present_budget.expense)}  </strong>".html_safe
    end
  end

  def see_pending_request
    pending=Expense.where(status: 'Pending').count + Leafe.where(status: 'Pending').count
    if pending > 0
      "<span class='badge'>
          #{pending}
      </span>".html_safe
    end
  end

  def check_in_out
    info = current_user.id.to_s + '=>' + Date.today.to_date.to_s
    attendance = Attendance.where(info: info).last
    if attendance != nil
      if attendance.status == true
        link_to ("Check Out <span class='status green'></span>").html_safe, attendance_path(attendance), method: :put, class: "dropdown-item", data: {confirm: "Are You Sure?"}
      else
        link_to ("Check In <span class='status red'></span>").html_safe, attendances_path, method: :post, class: "dropdown-item"
      end
    else
      link_to ("Check In <span class='status red'></span>").html_safe, attendances_path, method: :post, class: "dropdown-item"
    end
  end


end

