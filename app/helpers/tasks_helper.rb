module TasksHelper
  URL_REGEX = URI.regexp

  def linkified_title(title)
    return title unless title.match(URL_REGEX).present?
    title.gsub(URL_REGEX, '<a href="\0">\0</a>').html_safe
  end
end