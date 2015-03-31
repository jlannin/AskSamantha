Feature: Create a new recipe
  As a chef,
  so that I can share my creations with the world
  I want to be able to create new recipes.

  Background: the toy story has several products
    Given these recipes:
      | name           |    directions            | Ingredients              | cooking_time |
      | Toast and Jam  | Put jam on toast         | Toast 1, Jam 1           |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Egg 4, Milk 1, Butter 1  |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1, Milk 1         |  10          |

  Scenario: Creating a new recipe with an image
    Given I am on create new recipe page
    When I fill in the following:
      |Name        | new toast   |
      |Directions  |get new toast|
      #ingredients problem...
      #|Ingredients | Bread       |
      |Cooking time| 1           |
    When I attach the file "tenders_productimage.jpg" to "Image"
    And I press "Create Recipe"
    Then I should be on the recipes page
    #And I should see that "new toast" has directions of "get new toast"
    And I should see that "new toast" has a cooking time of "1 minute"
    And I should see that "new toast" has an image of "tenders_productimage.jpg"

  Scenario: Creating a new recipe with an image and deal with cook time
    Given I am on create new recipe page
    When I fill in the following:
      |Name        | new toast   |
      |Directions  |get new toast|
      #ingredients problem...
      #|Ingredients | Bread       |
      |Cooking time| 61          |
    When I attach the file "tenders_productimage.jpg" to "Image"
    And I press "Create Recipe"
    Then I should be on the recipes page
    #And I should see that "new toast" has directions of "get new toast"
    And I should see that "new toast" has a cooking time of "1 hour and 1 minute"
    And I should see that "new toast" has an image of "tenders_productimage.jpg"

