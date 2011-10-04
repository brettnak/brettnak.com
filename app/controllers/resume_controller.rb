class ResumeController < ApplicationController
  def index
    resumator          = Resumator::Generator.new
    resumator.frontend = Resumator::YamlFront.new
    resumator.backend  = Resumator::HtmlBack.new

    text = open( Rails.root.join( "config", "resume.yml" ) ).read
    @resume_html = resumator.process( text )

    @title = "Resume"
    render :template => "resume/resume"
  end  	
end