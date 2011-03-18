class Post < ActiveRecord::Base
  before_save :generate_markdown_content

  def generate_markdown_content
    text = GithubFlavoredMarkdown( self.markdown_content )
    markdown = Markdown.new( text )
    self.html_content = markdown.to_html
  end

  def html_id
    return self.title.gsub( /[^a-zA-Z0-9]/, "_" ).gsub( /__*/, "_" ).downcase
  end
end
