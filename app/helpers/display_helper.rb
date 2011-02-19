module DisplayHelper

  def render_movements(movements)
    render(:partial => 'movements/movements', :locals => {:movements => movements})
  end

  def render_report(report)
    render(:partial => 'reports/report', :locals => {:report => report}) if report
  end

  def render_tag_report(report)
    render(:partial => 'reports/tags', :locals => {:tags => report[:tags]}) if report and report[:tags]
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
