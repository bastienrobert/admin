module ApplicationHelper
  def cp(p, c)
    if current_page?(p)
      "active " + c
    else
      c
    end
  end
end
