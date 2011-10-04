require 'rubygems'
require 'haml'

class Resumator::HtmlBack < Resumator::Backend
  attr_accessor :renderer

  def initialize( options = {} )
    super
    dir  = File.dirname( __FILE__ )

    root = File.join( dir, "templates" )
    self.renderer = HamlRenderer.new( :root => root )
  end

  def process( hash )
    @resume = hash
    out = self.renderer.render( "resume", :scope => binding() )
    return out
  end

  # Because we're passing :scope => binding() into the haml engine,
  # we need a hook from here into the renderer.  We could just use
  # self.renderer, but since we'll be doing this all the time
  # let's make a convenient way to do it.
  def render( filename, options = {} )
    options[:scope] = binding() unless options[:scope]

    return self.renderer.render( filename, options )
  end

  # Any object that responds to both nil? and empty?
  def blank?( object )
    return object.nil? || object.empty?
  end
end

class Resumator::HtmlBack::HamlRenderer
  attr_accessor :template_root, :haml_options

  def initialize( options = {} )
    self.template_root = options.delete( :root )
    raise StandardError, "You must supply HamlRenderer with a root directory." if self.template_root.nil?

    self.haml_options = options.dup
  end

  # Filenames shouldn't have a begining "/"
  def render( filename, options = {} )
    # To allow different renderers in the future,
    # file extensions shouldn't be passed

    filename += ".html.haml"

    template = open( File.join( self.template_root , filename ) ).read
    engine   = Haml::Engine.new( template, self.haml_options )

    scope    = options.dup.delete( :scope ) || Object.new
    return engine.render( scope, options )
  end
end