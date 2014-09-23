module ApplicationHelper
  def markdown string
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(string.to_s).html_safe
  end
end