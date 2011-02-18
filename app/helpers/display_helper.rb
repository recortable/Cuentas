module DisplayHelper

  def render_movements(movements)
    render :partial => 'movements/movements', :locals => {:movements => movements}
  end

  def property(label, value)
    if value.present?
      content_tag :li, :class => 'property' do
        content_tag(:label, label) + content_tag(:span, value)
      end
    end
  end


  def js(text)
    escape_javascript(text)
  end

  def jss(text)
    "\"#{escape_javascript text}\""
  end


end
