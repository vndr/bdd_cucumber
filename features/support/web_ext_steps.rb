include HtmlSelectorsHelper
include PathHelper

When /^(.*) within ([^:"]+)$/ do |step, scope|
  selector = HtmlSelectorsHelper.selector_for(scope)
  steps %Q{
    Then #{step} at xpath "#{selector}"
  }
end

Then /^(.*) within ([^:]+):$/ do |step, scope, data|
  selector = HtmlSelectorsHelper.selector_for(scope)
#  Then "#{step} at xpath \"#{selector}\":", data
  step("#{step} at xpath \"#{selector}\":", data)
end

Then /^I locate the ([^:]+)$/ do |scope|
 selector = HtmlSelectorsHelper.selector_for(scope)
 @element = @browser.element_by_xpath(selector)
end 

# e.g.
# Then I will see the following links within the breadcrumb trail:
# | label1 | label2 |
# should map to 
# Then [I will see the following links] at xpath "//div[@id='breadcrumb']//div[contains(@class, 'breadcrumb')]/ul"

Then /^(.*) go to the ([^:"]+)$/ do |step, pageName|
  path = PathHelper.path_for(pageName)
  steps %Q{
  	Then I visit "#{path}"
  }
end

Then /^(.*) will be at the ([^:"]+)$/ do |step, pageName|
  path = PathHelper.path_for(pageName)
  steps %Q{
  	Then I will be at "#{path}"
  }
end