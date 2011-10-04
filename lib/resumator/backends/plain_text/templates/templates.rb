module PlainTextBackTemplates

FOOTER_INNER_TEMPLATE = <<EOD
* %<footer>s
EOD

HOBBIES_INNER_TEMPLATE = <<EOD
==  %<title>s
%<description>s

EOD

HOBBIES_OUTER_TEMPLATE = <<EOD
= %<title>s
%<hobbies_inner>s
EOD

EDUCATION_INNER_TEMPLATE = <<EOD
==  %<school>s
    %<degree>s
%<description>s
EOD

EDUCATION_OUTER_TEMPLATE = <<EOD
= %<title>s
%<education_inner>s
EOD

SKILLS_OUTER_TEMPLATE = <<EOD
= %<title>s
%<skills_inner>s
EOD

SKILLS_INNER_TEMPLATE = <<EOD
==  %<title>-20s %<duration>2s %<duration_phrase>-7s %<frequency>2s %<frequency_phrase>s
EOD

EXPERIENCE_OUTER_TEMPLATE = <<EOD
= %<title>s
%<experience_inner>s
EOD

EXPERIENCE_INNER_TEMPLATE = <<EOD
==  %<company>s
    %<title>s : %<start_date>s - %<end_date>s
%<description>s

EOD

PERSONAL_TEMPLATE = <<EOD
%<name>s
%<email>s
%<phone_area>s %<phone_prefix>s %<phone_postfix>s

EOD

end