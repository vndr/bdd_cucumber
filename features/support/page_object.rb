class Page
  include PageObject

#  direct_url "http://www.google.com"
#  expected_element :text_field, :name => "q"
#  expected_title "Google"
#This uses syntax from the PageObject gem - see https://github.com/cheezy/page-object

  button(:submit, :value => 'Submit')

  h3(:assign_authors, :text => "Assign Authors")
  
  link(:move_to_trash, :text => "Move to Trash")

end


class HRELandingPage < Page
  
  page_url "#{$SITEROOT}/en/human-rights-education/resource-centre"

  select_list(:language_filter, :name => 'filter_26')
  select_list(:occupation_filter, :name => 'filter_27')
  select_list(:type_of_resource_filter, :name => 'filter_22')
  select_list(:target_age_group_filter, :name => 'filter_23')
  select_list(:human_rights_education_topic_filter, :name => 'filter_25')
  select_list(:human_rights_topic_filter, :name => 'filter_5')
  select_list(:educational_settings_filter, :name => 'filter_20')

  div(:language_help_icon, :id => 'help-button-filter_26')
  div(:document_title, :class => 'title')

end












