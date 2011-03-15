# HAML & SASS initialization options
Haml::Template.options[ :format   ] = :html5
Haml::Template.options[ :encoding ] = "utf-8"

Sass::Plugin.options[:style] = :compact
Sass::Plugin.add_template_location( Rails.root.join( "app", "stylesheets" ).to_s )
