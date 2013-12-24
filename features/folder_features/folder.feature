Feature: Show Folders
  I want to crete folder

  Scenario: Folders List
    Given I have folders titled Folder1, Folder2
    When I go to the list of folders
    Then I should see "Folder1"
    And I should see "Folder2"