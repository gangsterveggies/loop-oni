module UsersHelper
  def get_grade_from_year (grad_year)
    return 12 + ((Time.now - Time.utc(0, 2, 17, 0, 0))/1.year).round - grad_year
  end
end