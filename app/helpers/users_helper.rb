module UsersHelper
  def get_grade_from_year (grad_year)
    12 + ((Time.now - Time.utc(0, 2, 17, 0, 0))/1.year).round - grad_year
  end

  def get_current_graduation_year()
    @cur = Date.today()
    if (@cur.month > 9)
      @cur.year + 1
    else
      @cur.year
    end
  end
end
