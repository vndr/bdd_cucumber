Then /^I should see meta tag with "([^"]*)" name$/ do |name|
  @browser.head.meta(:name => "#{name}").exists?.should be_true
end

Then /^I should see AI\-published, date and language meta tags in source$/ do
  @browser.head.meta(:name => "AI-published").exists?.should be_true
  @browser.head.meta(:name => "date").exists?.should be_true
  @browser.head.meta(:name => "language").exists?.should be_true
end
