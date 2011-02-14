module ApplicationHelper
  def title(label)
    content_for(:title) { label }
    content_tag(:h1, label, :class => 'title')
  end

  def icon_link_to(icon, text, url, params = {})
    clzz  = params[:class] ? params[:class] : ''
    extra = params.merge({:class => "icon icon_#{icon} #{clzz}", :title => text})
    link_to text, url, extra
  end

  def mes(month_number)
    I18n.t "months.month-#{month_number}"
  end
end
