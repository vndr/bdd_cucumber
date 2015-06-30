When /^I check a random set of users from the wire newsletter group$/ do
  
  get_DB_connection("civicrm")
  
  #pluck 10 users randomly from teh civicrm group contact table.
  start = rand(42000);
  #start = rand(990);
  #start = 0
  
  sql = "SELECT contact_id,group_id from civicrm_group_contact where group_id IN(5,10,12,14) LIMIT #{start},10"

  row = @DB.query(sql)
  
  @contacts = Array.new
  
   row.each_hash do | contact |
     user = User.new()
     user.contact_id = contact["contact_id"]
     user.language = groupid_to_language(contact["group_id"])
     @contacts.push(user)
   end

end

Then /^they should all have the wire and correct language set as an area of interest$/ do
   @contacts.each do |contact|
      cid = contact.contact_id
      language = contact.language
      steps %Q{
         When I visit "/en/civicrm/contact/view?reset=1&cid=#{cid}"
         When I click on the "Constituent Information" link
         Then I will see the text "Wire" within the civicrm areas of interest field
         Then I see text within the civicrm primary language
       }
  end
end
