Then /^I will see the registration page introductory text$/ do
  
  # strings
  heading = "Register for example.org"
  header_bumpf = "By registering on example.org you can join in on the human rights conversation and ensure your contributions are combined with ours. If you come from a country that doesn't have an office you have the option to become an International member. Here, you will receive emails about human rights campaigns that are targeted to your interests and opportunities to take action for human rights impact. You can also become a volunteer, and lead on example initiatives in your community. Furthermore, you will have full use of the example International online communities. We can't do it without you!"
  register_body_bumpf = "We have 50 international offices. This information will help us ensure that you receive the appropriate services. If you don't have an office in your country, you can join example International as an International Member"
  register_section_apologies = "If you prefer to join example International with one of our country offices, click your country below to be directed to their site"

  steps %Q{
  	Then I will see the heading "#{heading}"
  	Then I will see the text "#{header_bumpf}" within the registration header 
	  Then I will see the text "Where do you live?" within the highlighted section of the register stage indicator
  	Then I can see the text "#{register_body_bumpf}" after the heading "Where do you live?"
  	Then I can see the text starting with "#{register_section_apologies}" after the heading "Join example International in your region..."
  }
  
end

Then /^I will see the UK registration page form$/ do
    
  steps %Q{
	Then I will see the heading "Register for example.org"
	Then I will see the text "Your details" within the highlighted section of the register stage indicator
	Then I will see the heading "Your account"
	Then I will see the text "Mandatory fields for registration" within the block header

	Then I will see the form-required text "*"
	Then I will see the label "Username: "
	Then I will see the text input "name" and the field will be required
	
	Then I will see the form-required text "*"
	Then I will see the label "Email address: "
	Then I will see the text input required "mail" and the field will be required
	
	Then I will see the form-required text "*"
	Then I will see the label "Confirm e-mail address: "
	Then I will see the text input "conf_mail" and the field will be required
	Then I will see the text "Please re-type your e-mail address to confirm it is accurate." 
	
	Then I will see the label "Anonymity"
	Then I should see the dropdown box "edit-profile-anonymity-settings" 
	And I should be able to select "<anonymity>"
	
	Then I will see the text "Use this if you prefer to remain anonymous on example.org. This applies to both privacy settings"
	Then I will see the form-required text "*"
	Then I will see the label "Country of Residence: "
	Then I will see the <edit-country>
	Then I will see the text "You've selected a country with an example International section. Note that you will receive email communications from this office and not the International Secretariat."
	
	Then I will see the form-required text "*"
	Then I will see the label "example.org Language: "
	Then I will see the radio button "edit-language-en" with label " English"
	Then I will see the text "Set the language that you wish to view example.org. We will also occasionally send you emails and other forms of communication in this language."
	
	Then I will see the form-required text "*"
	Then I will see the label "Language of choice: "
	Then I should see a language Selector
	And I should be able to select "<language>"
	Then I will see the text "When engaging in example or conversing with other members, what language will you use?"
	
	Then I will see the text "Join Rights Journey"
	Then I will see the checkbox "edit-profile-rights-journey"
	Then I will see the text " By ticking this box, all the actions you take become 'steps' on the Rights Journey. Your steps are added to those of other activists all over the world who are heading for the same destination and you will see your own personal contribution in your profile page. "
	
	Then I will see the text "Notification"
	Then I will see the checkbox "edit-general-notification"
	Then I will see the text " Allow example.org to email you with notifications based on your activity. This includes community replies. You can customise these settings on your Account page once your account has been created."
	
	Then I will see the text "You and example.org"
	Then I will see the text "We will never make your contact details available outside of the example International Network. We will only contact you according to the selections you have made above."
	Then I will see the checkbox "edit-profile-community-guidelines"
	Then I will see the form-required text "*"
	Then I will see the text "I will abide by the "
	Then I will see the link called "Community Guidelines"
	
	Then I will see the link called "Cancel"
	Then I will see the submit button labeled "Next" 
  } 
end

Then /^I will see the registration confirmation form$/ do
  steps %Q{
	Then I will see the status message "You have just used your one-time login link. It is no longer possible to use this link to login. Please change your password."
	Then I will see the heading "Create your password <username>"
	Then I will see the text "Create password" within the highlighted section of the register stage indicator	
	Then I will see the text "Thanks for confirming your new account request. Enter your password here and then you're ready to create your profile for example.org"			
	Then I will see the form-required text "*"			
	Then I will see the label "Password: "			
	Then I will see the text input "edit-pass-pass1" and the field will be required		
		
	When I enter the value "<password>" into the "edit-pass-pass1" field
	Then I will see the text "Password strength:"
	Then I will see the password warning "<pass-warn>"
	Then I will see the form-required text "*"
	Then I will see the label "Confirm password: "
	
	When I enter the value "<password>" into the "edit-pass-pass2" field
	Then I will see the text "Password match:"
	Then I will see the password match "<pass-match>"
	Then I will see the text "Provide a password for the new account in both fields."
	Then I will see the text "I'm ready to join the human rights community"
	Then I will see the submit button labeled "Sign in"
  }
end