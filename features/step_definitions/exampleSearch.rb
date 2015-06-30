Given /^I am a user with correct permissions$/ do
  get_browser
  @browser.goto($SITEROOT + "/user/login?destination=node/1")
  username = $ADMINUSERNAME
  password = $ADMINPASSWORD

  @browser.text_field(:name, "name").exists?.should be_true
  @browser.text_field(:name, "pass").exists?.should be_true

  @browser.text_field(:name,"name").clear
  @browser.text_field(:name,"name").set(username)
  @browser.text_field(:name,"pass").clear
  @browser.text_field(:name,"pass").value=(password)
#OMG PONIES !!! chrome webdrive mucks up the first insert into the text field, so we have to re insert the string again ...  
  @browser.text_field(:name,"pass").clear
  @browser.text_field(:name,"pass").value=(password)

  @browser.button(:id, "edit-submit").click

  logged_in_user = "profile | Logout"
  @browser.text.include?(logged_in_user).should be_true

end

When /^I go to the "([^"]*)"$/ do |url|
  full_url = "#{$SITEROOT}/#{$SITE_LANGUAGE}#{url}"
  # @browser.goto(full_url)
  @browser.driver.navigate.to full_url
  if @browser.alert.exists? then
    @browser.alert.ok
  end
end

Then /^I should see "([^"]*)" in title$/ do |title|
  #@browser.h2.text.should include(title)
  @browser.text.should include(title)
end

Given /^that I have gone to the "([^"]*)" page$/ do |url|
  get_browser
  full_url = "#{$SITEROOT}/#{$SITE_LANGUAGE}#{url}"
  @browser.goto(full_url)
end

When /^I add "([^"]*)" to the search box$/ do |item|
    @browser.text_field(:name,"q").set(item)
end

When /^I add "([^"]*)" to the search box with name "([^"]*)"$/ do |item, name|
      @browser.text_field(:name, name).set(item)
end

When /^click the Search Button with name "([^"]*)"$/ do |name|
    @browser.button(:name, name).click
end

When /^I click Advanced Search link$/ do
#    debugger
    @browser.div(:id => /advanced-link-show/).link(:index => 0).when_present.click
end

When /^I choose Sort by Relevance$/ do
    @browser.radio(:value, 'relevance').set
end

When /^I add "([^"]*)" to the Advanced Search box with name "([^"]*)"$/ do |item, id|
    @browser.text_field(:id, id).set(item)
end

When /^click the Advanced Search Button with name "([^"]*)"$/ do |id|
    @browser.button(:id, id).click
end

Then /^"([^"]*)" should be set as language meta name content$/ do |lang|
#  debugger
    #  should include(item.downcase)
  @browser.meta(:name, "language").content.should include(lang)
end

Then /^"([^"]*)" should be set as date meta name content$/ do |date|
  @browser.meta(:name, "date").content.should include(date)
  @browser.meta(:name, "AI-published").content.should include(date)
end

