module Resumator
  class Generator
    attr_accessor :frontend, :backend, :middlewares

    def initialize
      # Include the standard middleware
      self.middlewares = [ VerbosifierMiddleware.new ]
    end

    def process( text )
      resume = self.frontend.process( text )

      self.middlewares.each do |middleware|
        resume = middleware.process( resume )
      end

      # Should be handled by the backend.  Usually print to STDOUT.
      # Sometimes that won't make sense though
      return self.backend.process( resume ) 
    end
  end
end