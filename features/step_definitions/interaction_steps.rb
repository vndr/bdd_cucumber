When /^I click on the "([^"]*)" link$/ do |text|
  @browser.link(:text, text).click
end

When /^I click the "([^"]*)" button$/ do |text|
  @browser.button(:text, text).click
end

When /^I click on the "([^"]*)" tab$/ do |text|
  link = @browser.element_by_xpath("//a[span[@class='tab' and text()='#{text}']]")
  link.should exist
  link.click
end

When /^I click on the event widget$/ do
  @browser.div(:id, "event-teaser-left").click
end

When /^I wait ([0-9]+) seconds$/ do |strcount|
  count = strcount.to_i
  sleep count
end

When /^I click on this link$/ do
  @element.click
end

When /^I hover over the word "([^"]*)" in the text "([^"]*)"$/ do |word, text|
  
  pass = false

  @browser.divs().each do |el|
    if el.text.gsub("\n", "") == text
      if el.span(:text, word).exists?
        @element = el.span(:text, word)   
        pass = true
      end
    end
  end

  pass.should be_true

end

When /^I select "([^"]*)" from the drop down list number "([^"]*)"$/ do |selection, index|
  @browser.select_list(:index, Integer(index)).select selection
end

Then /^I will enter the text "([^"]*)" into the text input "([^"]*)"$/ do |text, input|

#meh using id cos its unique, civicrm uses the same name for some fields : /
  @browser.text_field(:id, "#{input}").exists?.should be_true
  @browser.text_field(:id, "#{input}").clear
  @browser.text_field(:id, "#{input}").set(text)
end

Then /^I will submit the form "([^"]*)"$/ do | form_name |
  f = @browser.form(:name, "#{form_name}")
  f.submit
end



