require 'rubygems'
require 'yaml'

class Resumator::YamlFront < Resumator::Frontend

  def process( text, options = {} )
    return YAML::load( text )
  end

end
