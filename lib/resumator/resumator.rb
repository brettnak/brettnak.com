require 'rubygems'

module Resumator
  ROOT = File.dirname( __FILE__ )

  def Resumator.require( path )
    # First, try to require a path relative to the root of this package
    begin
      return relative_require( path )
    rescue LoadError => e ; end

    # Try the standard require
    return Kernel.require( path )
  end

  def Resumator.relative_require( path )
    Kernel.require( ROOT + "/#{path}" )
  end

  relative_require "./lib/base.rb"

  Dir.glob( ROOT + "/lib/*" ).each do |f|
    require( f )
  end

  # Require frontends
  Dir.glob( ROOT + "/frontends/*_front.rb" ).each do |f|
    require( f )
  end

  # Require backaends
  Dir.glob( ROOT + "/backends/*/*_back.rb" ).each do |f|
    require( f )
  end

  # Require middlewares
  Dir.glob( ROOT + "/middlewares/*" ).each do |f|
    require( f )
  end
end


if $0 == __FILE__
  cli = Resumator::CLI.new
  cli.main
end