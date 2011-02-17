module DisplayHelper

  def render_movements(movements)
    render :partial => 'movements/movements', :locals => {:movements => movements}
  end

end
