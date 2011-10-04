module Resumator
  ##
  # Support for almost all option passing is really limited now.
  #
  # TODO: Add better option parsing to pass FE, BE, and MW options
  #       from the CLI
  class CLI

    attr_accessor :options

    def initialize
      @generator = Generator.new
      self.options = parse_options

      @generator.frontend    = YamlFront.new
      @generator.backend     = HtmlBack.new
    end

    # TODO: Fill in
    def parse_options
      # pass, for now.
    end

    def main
      text = open( Resumator::ROOT + "/resume.yml" ).read
      out = @generator.process( text)
      puts out
    end
  end
end