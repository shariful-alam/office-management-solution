module ApplicationHelper

  def convert_to_dhaka(datetime)
     datetime=datetime.in_time_zone('Dhaka')
  end

  def full_date(datetime)
    datetime=convert_to_dhaka(datetime)
    datetime.strftime('%d %B, %Y')
  end

  def full_date_with_time(datetime)
    datetime=convert_to_dhaka(datetime)
    datetime.strftime('%d %B, %Y at %I:%M %p')
  end

  def only_time(datetime)
    datetime=convert_to_dhaka(datetime)
    datetime.strftime('%I:%M %p')
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
    present_budget= Budget.find_by(month: date.month, year: date.year)
    if present_budget.nil?
      "The budget is not added yet !".html_safe
    else
      "Budget for  #{Date::MONTHNAMES[present_budget.month]}, #{present_budget.year}
      Total :   #{taka(present_budget.amount)}
      Expense :   #{taka(present_budget.expense)}
      Remaining :  #{taka(present_budget.amount - present_budget.expense)}".html_safe
    end
  end

  def see_pending_request
    pending =Expense.where(status: 'Pending').count + Leafe.where(status: 'Pending').count + Income.where(status: 'Pending').count
    if pending > 0
      "<span class='badge'>
          #{pending}
      </span>".html_safe
    end
  end

  def check_in_out
    info = current_user.id.to_s + '=>' + Date.today.to_date.to_s
    attendance = Attendance.where(info: info).last
    if attendance.present?
      if attendance.status == true
        link_to ("Check Out <span class='status green'></span>").html_safe, attendance_path(attendance), method: :put, class: "dropdown-item", data: {confirm: "Are You Sure?"}
      else
        link_to ("Check In <span class='status red'></span>").html_safe, attendances_path, method: :post, class: "dropdown-item"
      end
    else
      link_to ("Check In <span class='status red'></span>").html_safe, attendances_path, method: :post, class: "dropdown-item"
    end
  end

  def find_class(income,target)

    if income > target
      return "bonusable"
    else
      return "not-bonusable"
    end
  end


  def bonus_amount(month, year, user)
    @income = Income.where(user_id: user.id, status: Income::APPROVED)
    if year.nil?
      @income = @income.where('extract(month from income_date) = ? AND extract(year from income_date) = ?', month, Date.today.year).sum(:amount)
    else
      @income = @income.where('extract(month from income_date) = ? AND extract(year from income_date) = ?', month, year).sum(:amount)
    end
    @bonus = 0
    if @income > user.target_amount
      @bonus = (@income - user.target_amount) * (user.bonus_percentage / 100.0)
    end

    return @bonus
  end


end

