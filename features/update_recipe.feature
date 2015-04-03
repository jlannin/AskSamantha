Feature: Update the recipe details
  As a chef,
  so that I can make sure all the recipe information is up to date,
  I want to be update the recipe details

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
      | Cereal!        | Milk first, then cereal  | Cereal 1, Milk 1        |  10          |


  Given I am on the recipes page
  When I follow "Cereal!"
  Then I should see "Milk first, then cereal"
  And I should see "Cereal 1"
  And I should see "Milk 1"
  And I should see "10"
  When I follow "Edit recipe details"


  Scenario: Update: delete an ingrediant
    When I delete ingredient "1"
    And I press "Update Recipe Details"
    Then I should see that "Milk" has a quantity of "1"
    And I should not see "Cereal"

  Scenario: Update a spcecific recipe's properties
    When I fill in the following:
      |Name                     | Cereal                     |
      |Directions               | CEREAL FIRST, then milk    |
      |Cooking time             | 12                         |
     # |Cooking time             | 12                         |
     # |ingreds[ingredient_1]    | 2		             |
    And I press "Update Recipe Details"
    Then I should see "CEREAL FIRST, then milk"
    And I should see that "Milk" has a quantity of "1"
    #And I should see that "Cereal" has a quantity of "2" 
    And I should see "12 minutes"

  Scenario: Update: change one ingredient quant
    #When I fill in "Directions" with "CEREAL FIRST, then milk"
    #And I fill in "Cooking time" with "61"
    When I fill in "ingreds[ingredient_5]" with "2"
    And I press "Update Recipe Details"
    Then I should see "Milk first, then cereal"
    And I should see that "Cereal" has a quantity of "2"
    And I should see that "Milk" has a quantity of "1"
    And I should see "10 minutes"


  Scenario: Update a recipe by adding a new ingredient
    When I follow "Add ingredient"
    Then I fill in "new_ingreds[newingredient_1]" with "1"
    And I select "Honey" for ingredient "1"
    And I press "Update Recipe Details"
    Then I should see that "Honey" has a quantity of "1"
    And I should see that "Cereal" has a quantity of "1"
    And I should see that "Milk" has a quantity of "1"
