@user_registration @in_progress
Feature: User Registration

  As an unregistered user beginning the registration process
  I want to be able to choose my country of residence
  So that the choices available to me are specific to my country.
  
  Scenario: Non logged in user on registration page can see a country selector.
    Given I am a logged out user
    When I visit the "registration" page
    Then I will see a list of countries in a drop down box
  
  Scenario: User should not be able to progress without selecting a country
    Given I am a logged out user
    And I am on the first registration step
    When I click the go button
    And I have not selected a country
    Then I am redirected back to the first registration step
  
  # Scenario: User should not be able to access any other registration pages without first selecting a country.
  # We don't think this is even possible so no test currently written  
  
  Scenario: User should be able to click through to section/structure web sites
    Given I am a logged out user
    And I am on the first registration step
    Then I can see a list of sections and structure
    And I can click on a section or structure be taken to the relevant contact page or website
  
  Scenario: Drop down country list should contain all example defined countries
    Given I am a logged out user
    And I am on the first registration step
    Then the list of countries in the drop down conforms to example's defined list
  
  Scenario: User should be aware of their progress on the registration process through a breadcrumb trail.
    Given I am a logged out user
    And I am on the first registration step
    Then I will see a breadcrumb of the registration steps
    And the first step will be highlighted
    
  Scenario: User should be able to progress to the Your Details section after selecting a country
    Given I am a logged out user
    And I am on the first registration step
    When I click select a country
    And I click the go button
    Then I am taken to the second registration step
  
  Scenario: Section/Structure country list should be complete.
    Given I am a logged out user
    And I am on the first registration step
    Then the full list of sections and structures is displayed
  
