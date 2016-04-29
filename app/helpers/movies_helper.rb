module MoviesHelper

  def formatted_date(date)
    if date
      date.strftime("%b %d, %Y")
    else
      nil
    end
  end

end
