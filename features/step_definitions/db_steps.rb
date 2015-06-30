Then /^I will see "([^"]*)" in the field "([^"]*)" in the table "([^"]*)" in the db "([^"]*)" where "([^"]*)" equals "([^"]*)"$/ do |search, field, table, db, wherefield, value|

  pass = false
    
  get_DB_connection(db)

  sql = "select " + field + " from " + table + " where " + wherefield + " = " + value
  
  row = @DB.query(sql)

  
  row.each do |resVal|
    if resVal[0].to_s() == search.to_s()
      pass = true
    end
  end

  pass.should be_true
  
end

Then /^this node is one of "([^"]*)"$/ do |typelist|

  pass = false
    
  get_DB_connection("drupal")

  sql = "select nid from node where nid = " + @nid + " and type in(" + typelist + ")"
  
  row = @DB.query(sql)

  
  row.each do |resVal|
    if resVal[0].to_s() == @nid.to_s()
      pass = true
    end
  end
    
  pass.should be_true
end

Then /^I have not already taken action on this node$/ do
  pass = true
    
  get_DB_connection("drupal")

  sql = "select txn_id from userpoints_txn where entity_id = " + @nid + " and uid = " + @uid
  
  row = @DB.query(sql)

  row.each do |resVal|
      pass = true
  end
    
  pass.should be_true
  
end

Then /^I will see the node published after "([^"]*)" minutes$/ do |delay|
  
  pass = false
  
  sleep (Integer(delay) * 60)

  timeNow = Time.now
  
  @browser.goto($SITEROOT + '/en/admin/reports/status/run-cron')

  get_DB_connection("drupal")

  sql = "select status from node where nid = " + @nid

  row = @DB.query(sql)
  
  row.each do |status|
    if status[0] == "1"
      pass = true
    end
  end


  pass.should be_true
      
end

Then /^I will see the node removed after "([^"]*)" minutes$/ do |delay|
  
  pass = true
  
  sleep (Integer(delay) * 60)

  @browser.goto($SITEROOT + '/en/admin/reports/status/run-cron')

  get_DB_connection("drupal")

  sql = "select status from node where nid = " + @nid

  row = @DB.query(sql)
  
  row.each do |status|
    if status[0] == "1"
      pass = false
    end
  end

  pass.should be_true
end

Then /^there will be no account in civicrm for the email "([^"]*)"$/ do |email|
  pass = true
    
  get_DB_connection("civicrm")

  sql = "select id from civicrm_email where email = '" +  email + "'"
  
  row = @DB.query(sql)

  row.each do |resVal|
      pass = false
  end
    
  pass.should be_true

end

Then /^there will be an account in civicrm for the email "([^"]*)"$/ do |email|
  pass = false
    
  get_DB_connection("civicrm")

  sql = "select id from civicrm_email where email = '" +  email + "'"
  
  row = @DB.query(sql)

  row.each do |resVal|
      pass = true
  end
    
  pass.should be_true

end

  
When /^I count the values in the "([^"]*)" table for "([^"]*)"$/ do |table, wherefield|
    where_clause = case wherefield
      when /total entries/ then
        "1=1"
 	    when /signups without countries/ then
 	      "country IS_NULL"
 	    when /signups with valid countries/ then
 	      "country NOT_LIKE '__'"
      when /invalid countries/ then

      "country != '' AND country NOT REGEXP '[A-Z][A-Z]'"
      else
        
        raise "Can't find mapping from \"#{wherefield}\" to a where_clause.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end

  sql = "select count(*) from " + table + " where " + where_clause

  db = "drupal"

  row = DB_query(sql,db)
  
  @vaule = row
  puts @value

end

Then /^ I will store the value as "([^"]*)"$/ do |key |
  @storage["#{key}"] = @value 
end

Then /^ I will retrive the value of"([^"]*)"$/ do | key |
  @storage["#{key}"]
end

Then /^ I will check the value of "([^"]*)" and the value of "([^"]*)" equal the value of "([^"]*)"$/ do | value1, value2, total |
  
  pass = false
  
  if @storage["#{value1}"] + @storage["#{value2}"] == @storage["#{total}"]
    pass = true
  end
  
  pass.should be_true
  
end

Then /^the result should equal "([^"]*)"$/ do | value1 |

  pass = false
  if @vaule == value1
    pass = true
  end
  
  pass.should be_true
end

Then /^the result should be empty$/ do 
  
  pass = false
  if @vaule.nil?
    pass = true
  end
end