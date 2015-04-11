Feature: Create a new 
  As a chef,
  so that I can share my creations with the world
  I want to be able to create new recipes.

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
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4, Milk 1,         |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1        |  10          |

  Scenario: Creating a new review
    Given I am on the recipes page
    When I press "Cereal"
    Then I should see "Write the first review"
    When I press "Write a review"
    And I fill in "Comments" with "Theyrrrree Greeeaat!"
    And I select "5" for rating
    And I press "Post Review"
    Then I should see "Review posted"
    And I should see that the review with "Theyrrrree Greeeat!" has a rating of "5"