require 'rubygems'
require 'json'

class VerbosifierMiddleware < Resumator::Middleware

  # By default, you will not need this.  Use it only when your middleware has
  # run-time initializations.
  # def initialize
  #   super
  # end

  # See plain_text_back.  This operates exactly the same way
  def validate_options( options )
    return nil
  end

  # Accepts a standard Resumator hash and returns a standard Resumator hash
  # This adds a :title element to each section of the resume since it is not
  # required at run time.  This makes sure the back-ends have perfectly clean
  # data.
  def process( resume )
    resume.map do |section_name, section_hash|
      if section_hash["title"].nil? || section_hash["title"].blank?
        section_hash["title"] = string_titleize( section_name.to_s )
      end
    end

    return resume
  end

  private
  def string_titleize( string )
    return string.split( "_" ).map { |word| word.capitalize }.join( " " )
  end
end
