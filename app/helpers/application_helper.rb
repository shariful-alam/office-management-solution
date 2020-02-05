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

  def find_by_month(month,user)
    #raise params[:search_by_year].inspect
    if params[:search].nil?
      @year = Date.today.year
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(month from income_date) = ? AND extract(year from income_date) = ?',month,@year).sum(:amount)
    else
      @year = params[:search]
      #raise @year.to_i.inspect
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(month from income_date) = ? AND extract(year from income_date) = ?',month,@year).sum(:amount)
    end
    return i
  end

  def find_total(user)
    if params[:search].nil?
      @year = Date.today.year
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(year from income_date) = ?', @year).sum(:amount)
    else
      @year = params[:search]
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(year from income_date) = ?', @year).sum(:amount)
    end
    return i
  end

  def find_class(month,user)
    if params[:search].nil?
      @year = Date.today.year
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(month from income_date) = ? AND extract(year from income_date) = ?',month,@year).sum(:amount)
    else
      @year = params[:search]
      i = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(year from income_date) = ?', @year).sum(:amount)
    end
    #raise i.inspect
    if i > user.target_amount.to_i
      return "bonusable"
    else
      return "not-bonusable"
    end
  end


  def bonus_amount(month,user)
    @income = Income.where(user_id: user.id, status: Income::APPROVED).where('extract(month from income_date) = ?', month).sum(:amount).to_i
    @bonus = (@income - user.target_amount) * (user.bonus_percentage / 100.0)
    return @bonus
  end


end

