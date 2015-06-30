When /^I go to the "([^"]*)" page$/ do |url|
 if !$SITE_LANGUAGE.nil?     
  full_url = "#{$SITEROOT}/#{$SITE_LANGUAGE}#{url}"
 else
  full_url = "#{$SITEROOT}#{url}"
 end
  @browser.goto(full_url)
end

When /^I go to the old "([^"]*)" url$/ do |url|
 if !$SITE_LANGUAGE.nil?     
  full_url = "#{$OLDSITEROOT}/#{$SITE_LANGUAGE}#{url}"
 else
  full_url = "#{$OLDSITEROOT}#{url}"
 end
  @browser.goto(full_url)
end

Then /^show me the cookies!$/ do
puts  @browser.driver.manage.all_cookies

#  @browser.driver.manage.all_cookies.each { |cookie|
#    open('cookie_en.csv','a') { |f|
#     f.puts "#{@aaa},#{cookie[:domain]},#{cookie[:expires]},#{cookie[:name]},#{cookie[:value]},#{cookie[:path]}"
#    }
#  }
end
