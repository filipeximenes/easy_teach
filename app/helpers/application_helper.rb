module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = ""
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def message_to_messageable_path(messageable)
    send_to_messages_path(messageable.class.to_s.underscore, messageable.id)
  end
end
