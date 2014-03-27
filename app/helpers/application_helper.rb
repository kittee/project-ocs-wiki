module ApplicationHelper
  def pluralize(number)
    if number != 1
      "s"
    end
  end
end
