Then /^I will be on a secure page$/ do
  @browser.url.split("://")[0].should == "https"
end

Then /^I will not be on a secure page$/ do
  @browser.url.split("://")[0].should == "http"
end

Then /^each of tabs should adhere to the key issue tab layout$/ do
  #Each tab will then have a header, two images (one header, one small) and then the descriptive text for the issue.
  pending # express the regexp above with the code you wish you had
end

Then /^I will see the country report list for ([^:"]+) at xpath "([^"]*)"$/ do |arg1,arg2|
    pending # express the regexp above with the code you wish you had
end

Then /^I will see (.*) at xpath "([^"]+)"$/ do |thing, xpath|
  selector = HtmlSelectorsHelper.selector_for(thing)
  el = @browser.element(:xpath, selector)
  el.should exist
end

Then /^I will see the following links at xpath "([^"]+)":$/ do |xpath, links|
  links.hashes.each do |hash|
    text = hash['link']
    href = hash['destination']
#    el = @browser.element_by_xpath(xpath + "//a[@href='#{href}'][contains(text(), '#{text}')]")
#    el = @browser.element(:xpath, "//a[@href='#{href}'][contains(text(), '#{text}')]")
    el = @browser.element(:xpath, "//a[@href='#{href}']")
    
    el.should exist
  end
end

Then(/^I will see the a4a branding in the top panel$/) do 
  @browser.div(:class => "a4aheader").exists?.should be_true
end

Then /^I will see the following options at xpath "([^"]+)":$/ do |xpath, options|
  options.hashes.each do |hash|
    text = hash['option']
    el = @browser.element(:xpath, "//option[text()='#{text}']")
    el.should exist
  end
end

Then /^I will see the text "([^"]*)"$/ do |text|
  pass = false
 
  @browser.elements().each do |el|
    divText = el.text
    if divText.gsub("\n", "") == text
      pass = true
    end
  end

  pass.should be_true

end

Then /^I will see the title text "([^"]*)"$/ do |text|
  title = @browser.title
  print "Title: class=", title.class, "; value=", title, "\n"
  title.should == text
end

Then /^I will see the text starting with "([^"]*)"$/ do |text|
    @browser.divs().detect{|el| el.text =~ /^#{text}/ }.should be_true
end

Then /^I will see the link starting with "([^"]*)"$/ do |text|
  pass = false
  @browser.links().each do |el|
    if el.text =~ /#{text}/
      pass = true
      @element = el
    end
  end
  pass.should be_true
end

Then /^I will see the text "([^"]*)" at xpath "([^"]*)"$/ do |text, xpathString|
  info = @browser.element_by_xpath(xpathString)
  info.text.should =~ /#{text}/
end


Then /^I will see the text containing "([^"]*)"$/ do |text|
    @browser.divs().detect{|el| el.text =~ /#{text}/ }.should be_true
end

Then /^I will see the text ending with "([^"]*)"$/ do |text|
    @browser.divs().detect{|el| el.text =~ /#{text}/ }.should be_true
end

Then /^I see text at xpath "([^"]*)"$/ do |xpathString|
    info = @browser.element_by_xpath(xpathString)
    info.text.should_not be_nil
    #boooom check that out for crazy syntax
end


Then /^I will see a link called "([^"]*)"$/ do |text|
  pass = false

  @browser.links().each do |el|
    if el.text == text
      pass = true
      @element = el
    end
  end

  pass.should be_true
end

Then /^I can see an event widget in the map$/ do
  map = @browser.div(:id, 'gmap-auto2map-gmap0')
  map.should exist
  widget = map.element_by_xpath("//*[@id='mtgt_unnamed_10']")
  widget.should_not be_nil
  @element = widget  
end


Then /^I can see an event popup$/ do
  popup = @browser.element_by_xpath("//div[@id='gmap-auto2map-gmap0']//div[@class='gmap-popup'][div[@class='rights-journey-calendar']]")
  popup.should exist
  @element = popup
end

Then /^I will see one of these links "([^"]*)"$/ do |textlist|
  pass = false

  @arrList = textlist.split(",")
  @browser.links().each do |el|
    
    @arrList.each do |value|
      if el.text == value
        pass = true
        @element = el
      end
    end
    
  end

  pass.should be_true
end


Then /^I will see the "([^"]*)" link$/ do |arg1|
  pass = false
  @browser.links.each do |link|
    if link.text == arg1
      pass = true
      @element = link
      break
    end
  end
  pass.should be_true
end

Then /^I will see the profile image$/ do
  pending # express the regexp above with the code you wish you had
end



Then /^I will see the "([^"]*)" view$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


# For DCPHELP-44
Then /^I can see "([^"]+)" in the ([^ ]+) taxonomy dropdown$/ do |term, dropdown|
  pass = false
  case dropdown
    when "Campaign"
      select = @browser.select_list(:id => "edit-campaign")
    when "Issue"
      select = @browser.select_list(:id => "edit-issue")
    when "Type"
      select = @browser.select_list(:id => "edit-tid")
  end
  
  select.should exist
  
  select.options().each do |opt|
    if opt.html =~ /#{term}/
      pass = true
      break
    end
  end
  pass.should be_true
end

# For DCPHELP-38
Then /^I can see at least ([0-9]+) results$/ do |strcount|
  pass = false
  count = strcount.to_i()
  pane = @browser.div(:class, "view-content")
  titles = pane.elements_by_xpath("//h3[@class='title']")
  titles.size.should >= count
end

# For DCPHELP-126
Then /^I will see ([0-9]+) action counters?$/ do |strcount|
  count = strcount.to_i()
  counters = @browser.elements_by_xpath("//div[@class='action-action']/div[@class='total-actions-count']")
  counters.size.should == count
end

Then /^I will see the tooltip called "([^"]*)"$/ do |tooltip|
  @element.title.should == tooltip 
end

Then /^I will see the "([^"]*)" link highlighted$/ do |link|
  pass = false

  @browser.links(:class, /rj-menu-active/).each do |el|
    if el.text == link
      pass = true
    end
  end

  pass.should be_true
end

Then /^I can see the text "([^"]*)" before this heading$/ do |text|
  xpath = "preceding::*//strong[contains(text(), '" + text + "')]"
  e = @element.element_by_xpath(xpath)
  e.text.should =~ /#{text}/
end

Then /^I can see the text "([^"]*)" before the heading that begins "([^"]*)"$/ do |text, heading|
  xpath = "//h1[starts-with(text(), '" + heading + "')]/preceding-sibling::*[contains(text(), '" + text + "')]"
  e = @browser.element_by_xpath(xpath)
  e.text.should == text
end

Then /^I can see the text "([^"]*)" after the heading "([^"]*)"$/ do |text, heading|
  h2 = @browser.h2(:text, heading)
  block = h2.parent
  divText = block.div().text
  divText.gsub("\n", "").should == text
end

Then /^I can see the text starting with "([^"]*)" after the heading "([^"]*)"$/ do |text, heading|
  h2 = @browser.h2(:text, heading)
  block = h2.parent
  divText = block.div().text
  divText.gsub("\n", "").should =~ /^#{text}/
end

Then /^I can see the text containing "([^"]*)" after the heading "([^"]*)"$/ do |text, heading|
  h2 = @browser.h2(:text, heading)
  block = h2.parent
  divText = block.div().text
  divText.gsub("\n", "").should =~ /#{text}/
end

Then /^I will see the heading "([^"]*)"$/ do |heading|
  xpath = "//*[(self::h1 or self::h2) and text()  = '#{heading}']"
  e = @browser.element_by_xpath(xpath)
  e.should exist
  @element = e
end

Then /^I can see the heading that contains "([^"]*)"$/ do |heading|
  xpath = "//*[(self::h1 or self::h2) and contains(text(), '" + heading + "')]"
  e = @browser.element_by_xpath(xpath)
  e.should exist
  @element = e
end


Then /^I will see a checkbox labelled "([^"]*)"$/ do |text|
  pass = false

  @browser.labels().each do |el|
    labelText = el.text
    if labelText == text
      pass = true
      @element = el
    end
  end
  
  if pass
    pass = false
    if @element.checkbox().exists?
      @element = @element.checkbox()
      pass = true
    end
    
  end
  
  pass.should be_true
end

Then /^this checkbox will be selected$/ do
  @element.checked?.should be_true
end

Then /^this control will be disabled$/ do
  @element.disabled?.should be_true
end

Then /^I will see a field labelled "([^"]*)"$/ do |label|
  oLabel = @browser.label(:text, label)
  block = oLabel.parent
  block.text_field().exists?.should be_true
end

Then /^this link points to a node$/ do
  @element.href.should =~ /(node)/
  @arrPath = @element.href.split("/")
  @nid = @arrPath[@arrPath.count - 1]
end

Then /^I will check that all links on the page work$/ do
  pass = false
  broken_links = Array.new
  my_links = @browser.links
   # use each one of collected links to do stuff. 
   my_links.each do |my_link| 
 
    if page_ok?("#{$SITEROOT}.#{my_link.href}") 
      pass = true
    end
  end 
    pass.should be_true
end

Then /^the title of this element is a link$/ do
  link = @element.element_by_xpath("//div[@class='title']/a")
  link.should exist
end

# Trying to find a way to grab a line on the map
# - Watir doesn't have a class for an svg element.
# - SVG elements don't appear in the html text that you can get from @browser.
# - Although firebug doesn't show them with a namespace, they have one.
# - Although firebug can see these svg elements, apparently Selenium/Firewatir can't.
# Unfair! Selenium/Firewatir is quite capable of finding a properly-namespaced XML element.  
Then /^I can see a line$/ do
  print @browser, "\n"
  print @browser.inspect, "\n"
  print @browser.driver.inspect, "\n"
  elements = @browser.elements
  # doc.should exist
  # elements = doc.all()
  print "Found ", elements.length, " elements\n"
  elements.each do |el|
    if el.tag_name == "svg"
      #print "Element: ", el.tag_name, "\n"      
      comps = el.elements
      comps.each do |comp|
        if comp.tag_name == 'path'
          print "\tPath stroke-width=: ", comp.attribute_value("stroke-width"), "\n"
          comp.fire_event("onmouseover")
          cmdiv = @browser.div(:id, 'cursorMessageDiv')
          cmdiv.should exist
          print "CMDIV: #{cmdiv.text}\n"
          steps = cmdiv.div.div(:class, 'steps')
          print "Steps: #{steps.text}\n"
          title = @browser.element_by_xpath("//div[@id='cursorMessageDiv']/div/div[@class='suitcase-title']")
          print "Title: #{title.text}\n"
        end        
      end
    end
  end
end


Then /^I can see the AddThis link$/ do
  link = @browser.element_by_xpath("//a[@class='addthis-button']/img")
  link.should exist
  @element = link  
end

Then /^I can see the AddThis popup$/ do
  popup = @browser.element_by_xpath("//div[@id='at15s']")
  popup.should exist
  popup.visible?.should be_true
end

# Added by MP for take action feature

Then /^I will see a field called "([^"]*)"$/ do |fieldname|
 
  pass = false
  
  if @browser.text_field(:name, fieldname).exists?
    @element = @browser.text_field(:name, fieldname)
    pass = true
  end
  
  pass.should be_true
  
end

Then /^this field will contain the value "([^"]*)"$/ do |fieldval|

  pass = false
  
  if @element.value == fieldval
    pass = true
  end
  
  pass.should be_true

end

Then /^this field is enabled$/ do
  pass = false
  
  if !@element.disabled?
    pass = true
  end
  
  pass.should be_true
end

Then /^I will see a dropdown box called "([^"]*)"$/ do |fieldname|
  pass = false
  
  if @browser.select(:name, fieldname).exists?
    @element = @browser.select(:name, fieldname)
    pass = true
  end
  
  pass.should be_true
end

Then /^I will see a checkbox called "([^"]*)"$/ do |fieldname|
  pass = false
  
  if @browser.checkbox(:name, fieldname).exists?
    @element = @browser.checkbox(:name, fieldname)
    pass = true
  end
  
  pass.should be_true
end

Then /^this checkbox will be "([^"]*)"$/ do |state|
  
  pass = false
  
  if state == "checked" && @element.checked?
    pass = true
  else 
    if state == "un-checked" && !@element.checked?
      pass = true
    end
  end
  
  pass.should be_true
end

Then /^I can see the "([^"]+)" tab$/ do |text|
  li = @browser.element_by_xpath("//li[a[span[@class='tab' and text()='#{text}']]]")
  li.should exist
  @element = li
end

Then /^I will see the submit button labeled "([^"]*)"$/ do |value|
  button = @browser.element_by_xpath("//input[@type='submit' and @value='#{value}']")
  button.should exist
  @element = button
end


Then /^this tab is selected$/ do
  @element.class_name.should =~ /active/
end

Then /^I can see the text "([^"]*)" followed immediately by the title$/ do |text|
  target = @browser.element_by_xpath("//div[text()='#{text}']/following-sibling::div[1][@class='rj-suitcase-feature-title']")
  target.should exist
end
