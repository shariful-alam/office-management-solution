json.incomes do
  json.array! @users_income do |user|
    json.set! user.name do
      json.January    @all_incomes[user.id][1]
      json.February   @all_incomes[user.id][2]
      json.March      @all_incomes[user.id][3]
      json.April      @all_incomes[user.id][4]
      json.May        @all_incomes[user.id][5]
      json.June       @all_incomes[user.id][6]
      json.July       @all_incomes[user.id][7]
      json.August     @all_incomes[user.id][8]
      json.September  @all_incomes[user.id][9]
      json.October    @all_incomes[user.id][10]
      json.November   @all_incomes[user.id][11]
      json.December   @all_incomes[user.id][12]
    end
  end
end

json.bonuses do
  json.array! @users_income do |user|
    json.set! user.name do
      json.January    @all_bonuses[user.id][1]
      json.February   @all_bonuses[user.id][2]
      json.March      @all_bonuses[user.id][3]
      json.April      @all_bonuses[user.id][4]
      json.May        @all_bonuses[user.id][5]
      json.June       @all_bonuses[user.id][6]
      json.July       @all_bonuses[user.id][7]
      json.August     @all_bonuses[user.id][8]
      json.September  @all_bonuses[user.id][9]
      json.October    @all_bonuses[user.id][10]
      json.November   @all_bonuses[user.id][11]
      json.December   @all_bonuses[user.id][12]
    end
  end
end
