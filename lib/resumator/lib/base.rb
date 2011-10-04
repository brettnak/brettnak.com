module Resumator
  class Base
    def self.require_relative( path )
      require File.dirname( __FILE__ ) + "/#{path}"
    end

    def process( arg, options = {} )
      raise MustImplementError, "You must implement #{self.class.to_s}#process."
    end

    def validate_options
      return nil
    end
  end
end