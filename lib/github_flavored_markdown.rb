# Source: https://github.com/github/github-flavored-markdown/blob/gh-pages/code.rb

require 'digest/md5'

class GithubFlavoredMarkdown

  def self.filter( text )
    # Extract pre blocks
    extractions = {}
    text.gsub!(%r{<pre>.*?</pre>}m) do |match|
      md5 = Digest::MD5.hexdigest(match)
      extractions[md5] = match
      "{gfm-extraction-#{md5}}"
    end

    # prevent foo_bar_baz from ending up with an italic word in the middle
    text.gsub!(/(^(?! {4}|\t)\w+_\w+_\w[\w_]*)/) do |x|
      x.gsub('_', '\_') if x.split('').sort.to_s[0..1] == '__'
    end

    # in very clear cases, let newlines become <br /> tags
    text.gsub!(/(\A|^$\n)(^\w[^\n]*\n)(^\w[^\n]*$)+/m) do |x|
      x.gsub(/^(.+)$/, "\\1  ")
    end

    # Insert pre block extractions
    text.gsub!(/\{gfm-extraction-([0-9a-f]{32})\}/) do
      extractions[$1]
    end

    return text
  end

end

def GithubFlavoredMarkdown( text )
  return GithubFlavoredMarkdown.filter( text )
end
