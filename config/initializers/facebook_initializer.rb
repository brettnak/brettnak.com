require 'json'
require 'uri'

module Facebook
  APP_ID       = "191877094185892"
  API_KEY      = "b3fbff729420adcb63e42cc0f95bd980"
  APP_SECRET   = "e9af5cc2d8f129357f054f3731bbe340"

  def Facebook.fields_json
    URI.escape( JSON(
                       [
                         { 'name'=>'name' },
                         { 'name'=>'first_name'},
                         { 'name'=>'last_name'},
                         { 'name'=>'email'},
  
                         { 'name'=>'role',
                           'description'=>'Are you registering as a Lead or Follow?',
                           'type'=>'select', 'options'=>{'lead'=>'Lead','follow'=>'Follow'},
                         },

                         { 'name'=>'groupon',
                           'description'=>'Did you purchase this class through Groupon?',
                           'type'=>'select', 'options'=>{'yes'=>'Yes','no'=>'No'},
                           'default'=>'no',
                          },

                         { 'name'=>'member',
                           'description'=>'Are you a Savoy Swing Club Member?',
                           'type'=>'select', 'options'=>{'yes'=>'Yes','no'=>'No'},
                           'default'=>'no',
                          },

                          {'name'=>'captcha'},
                       ]
                     ) )
  end
end
