@login @production
Feature: User login
 
    As a User 
    I would like to be able to log into example.org 
    So that I can use the extra features offered to site members

    Scenario: A logged out user with and existing account signing into the site
    
      Given I am a logged out user
      When I visit the login page and enter my username and password
      Then I will be logged in
      
    Scenario: A logged out user with enters a non existent username
    
      Given I am a logged out user
      When I visit the login page and a non existent username
      Then I will see an error message telling me the username was incorrect
    
    Scenario: A logged out user with enters the correct username but the wrong password
    
      Given I am a logged out user
      When I visit the login page and enter a correct username but incorrect password
      Then I will see an error message telling me the password incorrect