@iphone_validation

Feature: Checking if iphone registered users have validated their email addresses

  As a Stakeholder I would like to make users who have registered on the 
  iphone validate their email addresses before logging into example.org
  so that people cannot create bulk accounts for spam
  
  Scenario: A iphone registered user who has not validated their email address trying to log into example.org
  
    Given I am a non-validated logged-in iphone user
    And I visit any non iphone service and non validation page
    And I should see a message saying "You have registered via the iphone, but not validated your email address. Please check 'email_address' for a validation email and click the validate link. Or resend the validation email"
    Then I should be logged out
    
  Scenario: A iphone registered user who has clicked the validation link

    Given I am a validating logged-in iphone user
    And I have clicked the validation link
    And I should be taken to my accounts settings page
    And I should see a message saying "Thank you for registered via the iphone, and validating your email address."
    And the iphone user role should be removed from my account
    
  Scenario: A non registered user Using iphone app with no connectivity

    Given I am a non-registered iphone user
    And I have no network connectivity
    Then I should be able to view cached News
    And I should be able to view cached Actions
    And I should be able to view the candle
    And the register button should be in-active
    And the take action button should be in-active
    
  Scenario: A non registered user Using iphone app with a loss of connectivity
  
    Given I am a non-registered iphone user
    And if I have submitted my registration
    Then I should see the error "There was a problem submitting your registration - maybe you lost connectivity? Please resubmit the action when you have connectivity"

  Scenario: A non registered user Using iphone app with connectivity

    Given I am a non-registered iphone user
    And I have network connectivity
    Then I should be able to view current News
    And I should be able to view current Actions
    And I should be able to view the candle
    And the register button should be active
    And I should be able to Register
    And the take action button should be active
    And if I try and take an action I should go to the register page
    
Scenario: A registered user Using iphone app who is logged in with no connectivity

    Given I am a registered iphone user
    And I am logged in
    And I have no network connectivity
    Then I should be able to view cached News
    And I should be able to view cached Actions
    And I should be able to view the candle
    And the register button should be in-active
    And the take action button should be in-active
    And the status logo should show no connectivity
    
Scenario: A registered user Using iphone app who is logged in with connectivity
  
    Given I am a registered iphone user
    And I have network connectivity
    Then I should be able to view current News
    And I should be able to view current Actions
    And I should be able to view the candle
    And the register button should be in-active
    And the take action button should be active
    And I should be able to take an action
    And the status logo should show I am logged in
    
      
Scenario: A registered user Using iphone app who is logged in with a loss of connectivity

    Given I am a registered iphone user
    And I am logged in
    And I have no network connectivity
    And I have submitted an action
    Then I should see the error "There was a problem submitting your action - maybe you lost connectivity? Please resubmit the action when you have connectivity"
    And the status logo should show no connectivity
    
    
Scenario: A registered user Using iphone app who is not logged in with connectivity
    Given I am a registered iphone user
    And I am logged in
    And I have network connectivity   
    Then the application should try and log me in every 30 seconds
    And I should then be logged in
    And the status logo should show I am logged in
      
Scenario: A registered user Using iphone app who is logged in with connectivity and quits the application
    Given I am a registered iphone user
    And I am logged in
    And I quit the application
    And I have network connectivity 
    Then the application should end my login session on example.org
    
Scenario: A registered user Using iphone app who is logged in with no connectivity and quits the application
    Given I am a registered iphone user
    And I am logged in
    And I quit the application
    And I have no network connectivity 
    Then my login session on example.org will timeout after 1 day
     
      