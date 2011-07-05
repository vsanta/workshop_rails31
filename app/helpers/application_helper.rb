module ApplicationHelper
  FLASH_KEYS = [:notice, :alert]

  def flash_messages
    message = "".html_safe
    FLASH_KEYS.each do |key|
      value = flash[key]
      next if value.blank?
      message << content_tag(:p, value, :id => "flash_#{key}")
    end
    message
  end

  def js text
    "\"#{escape_javascript(text)}\"".html_safe
  end
end
