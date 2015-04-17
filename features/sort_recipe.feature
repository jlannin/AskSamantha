Feature: Sort recipes by name, rating, and cooking time
  As a chef,
  so that I can see which recipes are rated the best and are the quickest,
  I want to be able to sort by rating and cooking time.

  Background: We have several foods and recipes
    Given these foods:
      | name           |
      | Cereal         |
      | Milk           |
      | Honey          |
      | Jam            |
      | Eggs           |

    Given these recipes:
      | name           |    directions            | Ingredients             | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 1, Jam 1          |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4, Milk 1,         |  200         |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1        |  10          |

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

  Scenario: sort bu the average rating
    When I go to the recipes page
    Then I press "Login"
    Then I sign in
    Then I press "Cereal"
    Then I review "Cereal" with "5"
    Then I review "Cereal" with "3"
    Then I press "Back to recipes!"
    And I should see that the recipe "Cereal" has a rating of "4"
    And I press "Ratings"    
    Then I should see the recipe rating in sorted order






