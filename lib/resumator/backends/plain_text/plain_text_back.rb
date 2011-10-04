class Resumator::PlainTextBack < Resumator::Backend

  require( Resumator::ROOT + "/backends/plain_text/templates/templates.rb" )

  # By default, you don't need this.  Use it only if you have run-time initialization
  # for your backend.
  def initialize( options = {} )
    super
  end

  ###
  # This will be called before process.
  # If there are no errors, return nil.
  # If there are errors, return a hash of { :name => "message", :name => "message" }
  # 
  # This is purely optional.  You may leave it out if you have no options
  # However please include it if you're backend could fail do to a bad
  # or missing option.
  #
  # It is used primarily in conjuction with the CLI interface.  If don't want
  # to support the CLI interface, you may leave it out.  Options can still be
  # passed to it but they won't generate very useful error messages if they are
  # incorrect.
  def validate_options( options )
    # This backend takes no options
    return nil
  end

  # Accepts the standard Resumator hash and outputs as plain text
  def process( resume, options = {} )
    text  = ""
    text += process_personal( resume["personal"] )
    text += process_experience( resume["experience"] )
    text += process_skills( resume["skills"] )
    text += process_education( resume["education"] )
    text += process_hobbies( resume["hobbies"] )
    text += process_footer( resume["footer"] )

    return text
  end

  def process_personal( personal )
    return "" if personal.nil?

    return ( PlainTextBackTemplates::PERSONAL_TEMPLATE % {
      :name          => personal["name"],
      :email         => personal["email"],
      :phone_area    => personal["phone"]["area"],
      :phone_prefix  => personal["phone"]["prefix"],
      :phone_postfix => personal["phone"]["postfix"],
    } )

  end

  def process_experience( experience )
    return "" if experience.nil?

    inner = ""
    experience["entries"].each do |entry|
      inner_t = ( PlainTextBackTemplates::EXPERIENCE_INNER_TEMPLATE % {
        :company     => entry["company"],
        :title       => entry["title"],
        :start_date  => entry["start"],
        :end_date    => entry["end"],
        :description => word_wrap_indent( entry["description"], 80, 6 ),
      } )

      inner += inner_t
    end

    outer = ( PlainTextBackTemplates::EXPERIENCE_OUTER_TEMPLATE % {
      :title => experience["title"],
      :experience_inner => inner,
    } )

    return outer
  end

  def process_skills( skills )
    return "" if skills.nil?

    inner = ""
    skills["entries"].each do |entry|
      frequency_phrase = entry["frequency"].to_i > 1 ? skills["frequency"]["plural"] : skills["frequency"]["singular"]
      duration_phrase  = entry["duration"].to_i > 1  ? skills["duration"]["plural"]  : skills["duration"]["singular"]
      inner_t = PlainTextBackTemplates::SKILLS_INNER_TEMPLATE % {
        :title => entry["title"],
        :frequency => entry["frequency"],
        :frequency_phrase => frequency_phrase,
        :duration => entry["duration"],
        :duration_phrase => duration_phrase,
      }

      inner += inner_t
    end

    outer = PlainTextBackTemplates::SKILLS_OUTER_TEMPLATE % {
      :title => skills["title"],
      :skills_inner => inner,
    }
  end

  def process_education( education )
    return "" if education.nil?

    inner = ""
    education["entries"].each do |entry|
      inner_t = PlainTextBackTemplates::EDUCATION_INNER_TEMPLATE % {
        :school => entry["school"],
        :degree => entry["degree"],
        :description => word_wrap_indent( entry["description"], 80, 6 ),
      }

      inner += inner_t
    end

    outer = PlainTextBackTemplates::EDUCATION_OUTER_TEMPLATE % {
      :title => education["title"],
      :education_inner => inner
    }

    outer
  end

  def process_hobbies( hobbies )
    return hobbies if hobbies.nil?

    inner = ""
    hobbies["entries"].each do |entry|
      inner_t = PlainTextBackTemplates::HOBBIES_INNER_TEMPLATE % {
        :title => entry["title"],
        :description => word_wrap_indent( entry["description"], 80, 6 ),
      }

      inner += inner_t
    end

    outer = PlainTextBackTemplates::HOBBIES_OUTER_TEMPLATE % {
      :title => hobbies["title"],
      :hobbies_inner => inner,
    }

    outer
  end

  def process_footer( footer )
    return footer if footer.nil?

    out = ""
    footer["entries"].each do |entry|
      out_t = PlainTextBackTemplates::FOOTER_INNER_TEMPLATE % {
        :footer => entry
      }

      out += out_t
    end

    return out
  end

  def word_wrap_indent(text, line_length = 80, indent = 0)
    relative_line_length = line_length - indent

    # Seems to work, but copied off the internet
    out = text.gsub(/(.{1,#{relative_line_length}})( +|$\n?)|(.{1,#{relative_line_length}})/, "\\1\\3\n")

    out.split( "\n" ).map { |line| " "*indent + line }.join( "\n" )
  end
end














