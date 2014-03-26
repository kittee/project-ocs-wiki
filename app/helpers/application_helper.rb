module ApplicationHelper
  def pluralize(number)
    if number > 1
      "s"
    else
      ""
    end
  end
end
