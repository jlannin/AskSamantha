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

    Given these units:
      | unit     | conversion_factor  | 
      | cup      | 5                  |
      | liter    | 10                 |
      | teaspoon | 12                 |

    Given these recipes:
      | name           |    directions            | Ingredients                 | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 1 cup, Jam 1 liter    |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 1 liter    |  20          |
      | Cereal!        | Milk first, then cereal  | Cereal 1 cup, Milk 1 liter  |  10          |



  Given I am on the recipes page
  When I follow "Cereal!"
  Then I should see "Milk first, then cereal"
  And I should see "Cereal 1 cup"
  And I should see "Milk 1 liter"
  And I should see "10"
  When I follow "Edit recipe details"


  Scenario: Update: delete an ingrediant
    When I delete ingredient "1"
    And I press "Update Recipe Details"
    Then I should see that "Milk" has a quantity of "1 liter"
    And I should not see the ingredient "Cereal"
  
  Scenario: Update: setting to 0 should delete it
    When I fill in "old[ingreds[ingredient_5]]" with "0"
    And I press "Update Recipe Details"
    Then I should see that "Milk" has a quantity of "1 liter"
    And I should not see the ingredient "Cereal"


  Scenario: Update a spcecific recipe's properties
    When I fill in the following:
      |Name                     | Cereal                     |
      |Directions               | CEREAL FIRST, then milk    |
      |Cooking time             | 12                         |
    And I press "Update Recipe Details"
    Then I should see "CEREAL FIRST, then milk"
    And I should see that "Milk" has a quantity of "1 liter"
    And I should see "12 minutes"

  Scenario: Update: change one ingredient quant
    When I fill in "old[ingreds[ingredient_5]]" with "2"
    And I press "Update Recipe Details"
    Then I should see "Milk first, then cereal"
    And I should see that "Cereal" has a quantity of "2 cups"
    And I should see that "Milk" has a quantity of "1 liter"
    And I should see "10 minutes"

  Scenario: Update: non-unique ingredients
    When I select "Milk" for ingredient "5" food
    And I press "Update Recipe Details"
    And I should see "The update failed :( Unique ingredients are needed."


  Scenario: Update a recipe by adding a new ingredient
    When I press "Add ingredient"
    Then I fill in "new[new_ingreds[newingredient_1]]" with "2"
    And I select "Honey" for new ingredient "1" food
    And I select "teaspoon" for new ingredient "1" unit
    And I press "Update Recipe Details"
    Then I should see that "Honey" has a quantity of "2 teaspoons"
    And I should see that "Cereal" has a quantity of "1 cup"
    And I should see that "Milk" has a quantity of "1 liter"


  Scenario: Update a recipe by adding a new ingredient, non unique fails!
    When I press "Add ingredient"
    Then I fill in "new[new_ingreds[newingredient_1]]" with "2"
    And I select "Milk" for new ingredient "1" food
    And I select "teaspoon" for new ingredient "1" unit
    And I press "Update Recipe Details"
    Then I should see "The update failed :( Unique ingredients are needed."
    