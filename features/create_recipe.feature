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

    Given these units:
      | unit   | conversion_factor  | 
      | cup    | 5                  |
      | liter  | 10                 |

    Given these recipes:
      | name           |    directions            | Ingredients                 | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 1 cup, Jam 1 liter    |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 1 liter    |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1 cup, Milk 1 liter  |  10          |

  Scenario: Creating with no ingredients should fail
    Given I am on create new recipe page
    When I fill in the following:
      |Name                     | new toast         |
      |Directions               | Go to the Coop    |
      |Cooking time             | 67                |
    And I press "Create Recipe"
    Then I should be creating on create new recipe page
    And I should see "The create didn't work :( Need at least one ingredient when saving recipe."

  Scenario: Creating a new recipe
    Given I am on create new recipe page
    When I fill in the following:
      |Name                                     | New toast         |
      |Directions                               | Get a new toaster |
      |Cooking time                             | 121               |
      |newingreds[new_ingreds[newingredient_1]] | 7	            |
    Then I select "Jam" for new ingredient "1" food
    Then I select "cup" for new ingredient "1" unit
    And I press "Create Recipe"
    Then I should be on the recipes page
    And I should see "New recipe New toast was made"
    And I should see that "New toast" has a cooking time of "2 hours and 1 minute"
    When I follow "New toast"
    Then I should see that "Jam" has a quantity of "7 cups"

  Scenario: Creating a new recipe with an image
    Given I am on create new recipe page
    When I fill in the following:
      |Name                                     | Tenders           |
      |Directions                               | Go to the Coop    |
      |Cooking time                             | 12                |
      |newingreds[new_ingreds[newingredient_1]] | 7		    |
    Then I select "Jam" for new ingredient "1" food
    Then I select "cup" for new ingredient "1" unit
    And I attach the file "tenders_productimage.jpg" to "Image"
    And I press "Create Recipe"
    Then I should be on the recipes page
    And I should see "New recipe Tenders was made"
    And I should see that "Tenders" has a cooking time of "12 minutes"
    And I should see that "Tenders" has an image of "tenders_productimage.jpg"

  Scenario: Creating a new recipe with multiple ingredients should redirect to edit recipe page
    Given I am on create new recipe page
    When I fill in the following:
      |Name                                             | new toast         |
      |Directions                                       | Go to the Coop    |
      |Cooking time                                     | 67                |
      |newingreds[new_ingreds[newingredient_1]] | 7		    |
    Then I select "Jam" for new ingredient "1" food
    And I select "cup" for new ingredient "1" unit
    And I press "Add ingredient"
    Then I should see "New recipe new toast was made"
    Then I fill in the following:
      |new[new_ingreds[newingredient_1]] | 1                 |
    And I select "Honey" for new ingredient "1" food
    And I select "liter" for new ingredient "1" unit
    And I press "Update Recipe Details"
    Then I should see that "Jam" has a quantity of "7 cups"
    Then I should see that "Honey" has a quantity of "1 liter"
    Then I press "Back to recipes!"
    And I should see that "new toast" has a cooking time of "1 hour and 7 minutes"




   

