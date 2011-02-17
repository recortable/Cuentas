module DisplayHelper

  def render_movements(movements)
    render :partial => 'movements/movements', :locals => {:movements => movements}
  end

  def js(text)
    escape_javascript(text)
  end

  def jss(text)
    "\"#{escape_javascript text}\""
  end


end
