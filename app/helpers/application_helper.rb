module ApplicationHelper
  def pluralize(number)
    if number == 1
      ""
    else
      "s"
    end
  end
end
