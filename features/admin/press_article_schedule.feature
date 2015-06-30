@admin @qa
Feature: Press Article Scheduling

    As a User
    I want to schedule a date when a press release is published and un-published on the site

        Scenario: I create a press release with specific publishing dates and it is correctly shown and hidden

        Given I am a logged in user as "markp22" with password "cbr900rr"
        When I visit "/en/node/add/press-release"
		And I enter "Auto Test" into the "title" field
		And I schedule the node to be published in "3" minutes time
		And I schedule the node to be removed in "6" minutes time
		And I create the node
		Then I will see the node published after "4" minutes
		And I will see the node removed after "7" minutes