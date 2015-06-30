Given /^that I have gone to the Google page$/ do
  get_browser
  fullpath = "www.google.co.uk"
  @browser.goto(fullpath)
end

When /^I add "([^"]*)" to the search box$/ do |item|
    @browser.text_field(:name,"q").set(item)
end

When /^click the Search Button$/ do
  @browser.button(:name, "btnG").click
end

Then /^"([^"]*)" should be mentioned in the results$/ do |item|
    @browser.text.downcase.should include(item.downcase)
end
