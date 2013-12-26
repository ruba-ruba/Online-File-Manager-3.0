Feature: Show Folders
  I want to crete folder

  Scenario: Folders List
    Given I have folders titled Folder1, Folder2
    When I go to the list of folders
    Then I should see "Folder1"
    And I should see "Folder2"

  Scenario: User creates new folder
    Given a user visits sing in page
      And user visits the new folder page when he is logged in
    When a user submits a valid information
    Then he should see a success message
      And a new folder should be created

  Scenario: User doesn't fill in form fields
    Given a user visits sing in page
      And user visits the new folder page when he is logged in
    When a user doesn't fill Title form
    Then he should see an error message about blank title
      And no new folder should be created

  Scenario: User creates a folder with the same title
    Given a user visits sing in page
      And user visits the new folder page when he is logged in
    When a user inputs the duplicate title
    Then he should see an error message about duplicate title
      And no new folder should be created
