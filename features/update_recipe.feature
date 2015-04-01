Feature: Update the recipe details
  As a chef,
  so that I can make sure all the recipe information is up to date,
  I want to be update the recipe details

  Background: the toy story has several products
    Given these recipes:
      | name           |    directions            | Ingredients              | cooking_time |
      | Toast and Jam  | Put jam on toast         | Toast 1, Jam 1           |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Egg 4, Milk 1, Butter 1  |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1         |  10          |
  Given I am on the recipes page
  When I follow "Cereal"
  Then I should see "Milk first, then cereal"
  And I should see "Cereal 1"
  And I should see "Milk 1"
  And I should see "10"
  When I follow "Edit recipe details"


  Scenario: Update a spcecific recipe
    When I fill in "Directions" with "CEREAL FIRST, then milk"
    And I fill in "Cooking time" with "128"
    And I fill in "Change ingredients" with "Milk 1"
    And I press "Update Recipe Details"
    Then I should see "CEREAL FIRST, then milk"
    And I should see "Milk 1"
    And I should not see "Cereal 1"
    And I should see "2 hours and 8 minutes"

  Scenario: Update a spcecific recipe
    When I fill in "Directions" with "CEREAL FIRST, then milk"
    And I fill in "Cooking time" with "61"
    And I fill in "Change ingredients" with "Cereal 1, Milk 2, Spoon 1"
    And I press "Update Recipe Details"
    Then I should see "CEREAL FIRST, then milk"
    And I should see "Cereal 1"
    And I should see "Milk 2"
    And I should see "Spoon 1"
    And I should see "1 hour and 1 minute"