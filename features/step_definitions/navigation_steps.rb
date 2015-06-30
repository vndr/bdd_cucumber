require 'uri'

When /^I visit "([^"]*)"$/ do | url |
  @browser.goto($SITEROOT + url)
end

Given /^I have visited an action in the example center$/ do
  steps %Q{
    Given I am a user
    When I view the example center featured action
  }
end

When /^I view the example center featured action$/ do
    steps %Q{
      Then I go to the example center
      Then I locate the example center featured action
      Then I click on this link
    }   
    sleep 5
end

When /^I navigate to the home page$/ do
      steps %Q{
        Then I locate the home page link
        Then I click on this link
      }
      sleep 5
end

# dupe here, not sure about this form of words
# NOTE that this step matches only the <length> leading chars of the URL against the
# path, where <length> is the length of the path. 
Then /^I will be at "([^"]*)"$/ do |path|
  prefix = $SITEROOT + path
  @browser.url[0, prefix.length].should == prefix
end

Then /^I will be at the url "([^"]*)"$/ do |path|
  url = $SITEROOT + path
  uri = URI(url)
  url = uri.scheme + '://' + uri.host + path 
  @browser.url.should == url
end

Then /^I will go to "([^"]*)"$/ do |path|
  prefix = $SITEROOT + path
  @browser.url[0, prefix.length].should == prefix
end