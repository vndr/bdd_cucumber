Given /^I am a user$/ do
  steps %Q{
    Given I am a logged out user
  }
end

Given /^I am a logged out user$/ do
  get_browser
end

Given /^I am a Admin user$/ do
  username = $ADMINUSERNAME
  password = $ADMINPASSWORD
  steps %Q{
    Given I am a logged in user as "#{$ADMINUSERNAME}" with password "#{$ADMINPASSWORD}"
  }
end

Given /^I am a logged in user as "([^"]*)" with password "([^"]*)"$/ do |user, pwd|
  get_browser
  @browser.goto($SITEROOT)
  @browser.goto($SITEROOT + "/user/login?destination=node/1")
  
  @browser.text_field(:name, "name").exists?.should be_true
  @browser.text_field(:name, "pass").exists?.should be_true

  @browser.text_field(:name,"name").clear
  @browser.text_field(:name,"name").set(user)
  @browser.text_field(:name,"pass").clear
  @browser.text_field(:name,"pass").value=(pwd)
#OMG PONIES !!! chrome webdrive mucks up the first insert into the text field, so we have to re insert the string again ...  
  @browser.text_field(:name,"pass").clear
  @browser.text_field(:name,"pass").value=(pwd)

  @browser.button(:id, "edit-submit").click

  logged_in_user = "profile | Logout"
  @browser.text.include?(logged_in_user).should be_true

#  get_DB_connection("drupal")

#  sql = "select uid from users where name = '" + user + "'"
  
#  row = @DB.query(sql)

#  row.each do |uid|
#    @uid = uid[0]
#  end
  
end

Then /^I will log in with the username "([^"]*)" and with the password "([^"]*)"$/ do |user, pwd|
  @browser.goto($SITEROOT + "/user/login?destination=node/1")

  @browser.text_field(:name, "name").exists?.should be_true
  @browser.text_field(:name, "pass").exists?.should be_true

  @browser.text_field(:name,"name").clear
  @browser.text_field(:name,"name").set(user)

  @browser.text_field(:name,"pass").clear
  @browser.text_field(:name,"pass").set(pwd)

  @browser.button(:id, "edit-submit").click
end


Given /^I am an RJ user$/ do
  @browser.goto($SITEROOT + "/user")
  @browser.link(:text, "Account settings").click
  @browser.checkbox(:name, "profile_rights_journey").set?.should be_true
end

Given /^"([^"]*)" is not anonymous$/ do |uid|
  
  pass = false
    
  get_DB_connection("drupal")

  sql = "select value from profile_values where fid = 6 and uid = " + uid
  
  row = @DB.query(sql)

  row.each do |retVal|
    if retVal[0] == "0"
      pass = true
    end
  end
  
  pass.should be_true
  
  #@browser.goto($SITEROOT + "/user/" + uid)
  #@browser.h2(:class=>"pane-title", :text=>"User profile Anonymous").exists?.should be_false
end

Given /^"([^"]*)" is an RJ user$/ do |uid|
  
  pass = false
    
  get_DB_connection("civicrm")

  sql = "select "
  sql += "membership_programmes_12 "
  sql += "from "
  sql += "civicrm_value_1_constituent_information cci "
  sql += "inner join civicrm_uf_match cm on cci.entity_id = cm.contact_id "
  sql += "where "
  sql += "cm.uf_id = " + uid
  
  row = @DB.query(sql)

  row.each do |retVal|
    if retVal[0] =~ /rights_journey/
      pass = true
    end
  end
  
  pass.should be_true
  
  #@browser.goto($SITEROOT + "/user/" + uid)
  #@browser.link(:href, "/en/rightsjourney").exists?.should be_true
end


When /^I visit the login page and enter my username and password$/ do
  steps %Q{
    Then I will log in with the username "testuser" and with the password "password"
  }
end

Then /^I will be logged in$/ do
  @browser.text.include?("Logged in as")
end

When /^I visit the login page and a non existent username$/ do
  steps %Q{
    Then I will log in with the username "maduptestuser" and with the password "password"
  }
end

Then /^I will see an error message telling me the username was incorrect$/ do
  @browser.text.include?("Incorrect Username").should be_true
end

When /^I visit the login page and enter a correct username but incorrect password$/ do
  steps %Q{
    Then I will log in with the username "testuser" and with the password "wrongpassword"
  }
end

Then /^I will see an error message telling me the password incorrect$/ do
  @browser.text.include?("Incorrect Password").should be_true
end

