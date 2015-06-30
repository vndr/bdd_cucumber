@comments @in_progress
Feature: Comments
 As a user of example.org
 I want to be able to view & post comments
 So that I can engage with editorial content

    Scenario: I visit a comment enabled page when i'm not signed in and there are no comments
		Given I am a logged out user
		When I visit a page that has comments enabled
		And there are no comments available
		Then I will see an invitation to sign-in
		And I will see the marketing text
		And in invitation to register
		
    Scenario: I visit a comment enabled page when i'm not signed in and there are less than 11 comments 
		Given I am a logged out user
		When I visit a page that has comments enabled
		And there are less than 11 comments available
		Then I will see an invitation to sign-in
		And I will see the comments attached to the page

	Scenario: I visit a comment enabled page when i'm not signed in and there are more than 10 comments 	
		Given I am a logged out user
		When I visit a page that has comments enabled
		And there are more than 10 comments available
		Then I will see an invitation to sign-in
		And I will see the comments attached to the page
		And I will see the pagination bar

	Scenario: I visit a comment enabled page when i'm signed in and I can post a comment
		Given I am a logged in user
		When I visit a page that has comments enabled
		And there are no comments available
		Then I will see	the detailed comment teaser text
		And I will be able to post a comment
		And I will see links associated with my user profile
		
	Scenario: I post a comment and see the comment preview
		Given I am a logged in user
		When I visit a page that has comments enabled 
		And I submit a comment
		Then I will see the preview comment usability text
		And I will see my comment in preview
		And I will see the comment preview options
		And I will see links associated with my user profile
