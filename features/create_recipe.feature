Feature: Create a new recipe
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

  Scenario: Creating a new recipe
    Given I am on create new recipe page
    When I fill in the following:
      |Name                     | New toast         |
      |Directions               | Get a new toaster |
      |Cooking time             | 121               |
      |ingreds[newingredient_1] | 7		    |
    Then I select "Jam"
    And I press "Create Recipe"
    Then I should be on the recipes page
    And I should see "New recipe New toast was made"
    And I should see that "New toast" has a cooking time of "2 hours and 1 minute"
    When I follow "New toast"
    Then I should see that "Jam" has a quantity of "7"

  Scenario: Creating a new recipe with an image
    Given I am on create new recipe page
    When I fill in the following:
      |Name                     | Tenders           |
      |Directions               | Go to the Coop    |
      |Cooking time             | 12                |
      |ingreds[newingredient_1] | 7		    |
    Then I select "Jam" for ingredient "1"
    And I attach the file "tenders_productimage.jpg" to "Image"
    And I press "Create Recipe"
    Then I should be on the recipes page
    And I should see "New recipe Tenders was made"
    And I should see that "Tenders" has a cooking time of "12 minutes"
    And I should see that "Tenders" has an image of "tenders_productimage.jpg"

  Scenario: Creating a new recipe with multiple ingredients
Given I am on create new recipe page
    And I follow "Add ingredient"
    When I fill in the following:
      |Name                     | new toast         |
      |Directions               | Go to the Coop    |
      |Cooking time             | 67                |
      |ingreds[newingredient_1] | 7		    |
      |ingreds[newingredient_2] | 13                |
    Then I select "Jam for ingredient "1"
    And I select "Honey" for ingredient "2"
    And I press "Create Recipe"
    Then I should be on the recipes page
    And I should see "New recipe new toast was made"
    And I should see that "new toast" has a cooking time of "1 hour and 7 minutes"
    And I should see that "Jam" has a quantity of "7"
    And I should see that "Honey" has a quantity of "13"

