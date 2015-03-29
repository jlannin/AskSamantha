Feature: Filter and sort recipes by name, rating, and cooking time
  As a chef,
  so that I can see which recipes are rated the best and are the quickest,
  I want to be able to sort and filter by rating and cooking time.

  Background: the toy story has several products
    Given these Recipes:
      | name           |    directions            | Ingredients             | cookingtime |
      | Toast and Jam  | Put jam on toast         | Toast 1, Jam 1          |  7          |
      | Scrambled Eggs | Eggs then milk, scramble | Egg 4, Milk 1, Butter 1 |  20         |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1        |  10         |

  Scenario: sort by name
    When I go to the recipes page
    And I fill in "Minimum age" with "2"
    And I press "Filter products"
    Then I should be on the products page
    And I should see "slinky"
    And I should see "fluffy bunny"
    But I should not see "ball"

  Scenario: filter by maximum price
    When I go to the products page
    And I fill in "Maximum price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"

  Scenario: sort by price
    When I go to the recipes page
    And I press "Cooking Time"
    Then I should be on the recipes page
    Then I should see recipe cooking_time in sorted order

  Scenario: sort by name
    When I go to the products page
    And I press "Name"
    Then I should be on the products page
    Then I should see product name in sorted order

  Scenario: remember sorting settings
    When I go to the products page
    And I press "Name"
    And I press "Create a new product"
    Then I should be on the create new product page
    When I press "Back to product list"
    Then I should be on the products page
    Then I should see product name in sorted order

  Scenario: remember filter settings
    When I go to the products page
    And I fill in "Maximum price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    When I press "Price"
    Then I should be on the products page
    And I should see product price in sorted order
    When I press "slinky"
    Then I go to the products page
    Then I should see product price in sorted order
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"

  Scenario: sort first, then remember filter and sorting settings
    When I go to the products page
    Then I press "Price"
    Then I should be on the products page
    And I should see product price in sorted order
    And I fill in "Maximum price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    And I should see product price in sorted order
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"

  Scenario: remember filtering without sorting
    When I go to the products page
    And I fill in "Maximum price" with "3.50"
    And I press "Filter products"
    Then I should be on the products page
    When I press "slinky"
    When I press "Back to product list"
    Then I should be on the products page
    And I should see product name in sorted order
    And I should see "slinky"
    But I should not see "fluffy bunny"
    And I should not see "ball"
