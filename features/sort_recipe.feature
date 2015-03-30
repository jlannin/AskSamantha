Feature: Sort recipes by name, rating, and cooking time
  As a chef,
  so that I can see which recipes are rated the best and are the quickest,
  I want to be able to sort by rating and cooking time.

  Background: the toy story has several products
    Given these recipes:
      | name           |    directions            | Ingredients              | cooking_time |
      | Toast and Jam  | Put jam on toast         | Toast 1, Jam 1           |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Egg 4, Milk 1, Butter 1  |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1         |  10          |

  Scenario: sort by name
    When I go to the recipes page
    And I press "Name"
    Then I should be on the recipes page
    Then I should see recipe name in sorted order
    When I press "Toast and Jam"
    Then I press "Back to recipes!"
    Then I should be on the recipes page
    And I should see recipe name in sorted order

  Scenario: sort by cooking time
    When I go to the recipes page
    And I press "Cooking Time"
    Then I should be on the recipes page
    Then I should see recipe cooking time in sorted order
    When I press "Cereal"
    Then I press "Back to recipes!"
    Then I should be on the recipes page
    And I should see recipe cooking time in sorted order