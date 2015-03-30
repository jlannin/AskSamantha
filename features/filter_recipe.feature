Feature: Filter recipes by cooking time and rating
  As a chef,
  so that I can quickly select recipes that meet certain criteria,
  I want to be able to filter recipes by rating and cooking time.

  Background: the toy story has several products
    Given these recipes:
      | name           |    directions            | Ingredients              | cooking_time |
      | Toast and Jam  | Put jam on toast         | Toast 1, Jam 1           |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Egg 4, Milk 1, Butter 1  |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1         |  10          |

  Scenario: filter by cooking time
    When I go to the recipes page
    And I fill in "Meals in" with "11"
    And I press "Filter recipes"
    Then I should be on the recipes page
    And I should see "Toast and Jam"
    And I should see "Cereal"
    But I should not see "Scrambled Eggs"
    When I press "Filter recipes"
    Then I should be on the recipes page
    And I should see "Toast and Jam"
    And I should see "Cereal"
    And I should see "Scrambled Eggs"

  Scenario: filter by cooking time persists
    When I go to the recipes page
    And I fill in "Meals in" with "11"
    And I press "Filter recipes"
    Then I should be on the recipes page
    And I should see "Toast and Jam"
    And I should see "Cereal"
    But I should not see "Scrambled Eggs"
    When I press "Cereal"
    Then I press "Back to recipes!"
    Then I should be on the recipes page
    And I should see "Toast and Jam"
    And I should see "Cereal"
    But I should not see "Scrambled Eggs"

  Scenario: filter and sorting by cooking time persists
    When I go to the recipes page
    And I fill in "Meals in" with "11"
    And I press "Filter recipes"
    Then I should be on the recipes page
    Then I press "Cooking Time"
    When I press "Cereal"
    Then I press "Back to recipes!"
    Then I should be on the recipes page
    And I should see "Toast and Jam"
    And I should see "Cereal"
    But I should not see "Scrambled Eggs"
    And I should see recipe cooking time in sorted order