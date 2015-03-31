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

  Scenario: Update a spcecific recipe
    Given I am on the recipes page
    When I follow "Cereal"
    Then I should see "Milk first, then cereal"
    #And I should see "Cereal 1, Milk 1"
    And I should see "10"
    When I follow "Edit recipe details"
    And I fill in "Directions" with "CEREAL FIRST, then milk"
    And I fill in "Cooking time" with "6"
    And I press "Update Recipe Details"
    Then I should see "CEREAL FIRST, then milk"
   #And I should see "Cereal 1, Milk 1"
    And I should see "6"
