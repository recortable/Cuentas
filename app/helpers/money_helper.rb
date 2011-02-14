# encoding: UTF-8


module MoneyHelper
  def euros_of(number, options = {})
    clazz = options[:class] ? options[:class] : ''
    clazz = clazz + " #{(number >= 0 ? 'positive ammount' : 'negative ammount')}"
    content_tag(:span, euros(number), {:class => clazz}.merge!(options))
  end

  def euros(number, options={})
    # :currency_before => false puts the currency symbol after the number
    # default format: $12,345,678.90
    options = {:currency_symbol => " €", :delimiter => ".", :decimal_symbol => ",", :currency_before => false, :absolute => false}.merge(options)
    number  = number.abs if options[:absolute]

    # split integer and fractional parts
    int, frac = ("%.2f" % (number / 100)).split('.')
    # insert the delimiters
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")

    if options[:currency_before]
      options[:currency_symbol] + int + options[:decimal_symbol] + frac
    else
      int + options[:decimal_symbol] + frac + options[:currency_symbol]
    end
  end
end
