Feature: User "cooking"
  As a chef,
  so that my fridge will be updated after I cook a recipe,
  I want my fridge to remove used ingredients when I cook recipes!

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
      | teaspoon | 7                  |

    Given these recipes:
      | name           |    directions            | Ingredients                              | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 4 cup, Jam 2 liter, Eggs 3 cup     |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 5 liter, Jam 2 liter    |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 2 cup, Milk 2 liter, Honey 2 cup  |  10          |

    Given a user with these groceries:
      | groceries                |
      | Honey 2 cup              |
      | Milk 3 liter             |
      | Cereal 5 cup             |


  Scenario: When I cook recipes (after what can I cook?), my fridge should be updated
    When I view my fridge
    Then I press "What can I cook?"
    Then I should be on the cookable recipes page
    And I should see that I can cook "Cereal"
    Then I press "Cook Recipe"
    Then I should be on my fridge
    Then I should see that "Cereal" has a quantity of "3 cups"
    Then I should see that "Milk" has a quantity of "1 liter"
    And I should not see "Honey"

  Scenario: When I cook recipes (after what can I cook?), my fridge should be updated
    When I view my fridge
    Then I go to the recipes page
    Then I press "Toast and Jam"
    Then I press "Cook Recipe"
    Then I should be on my fridge
    And I should see that "Cereal" has a quantity of "5 cups"
    And I should see that "Milk" has a quantity of "3 liters"
    And I should not see "Honey"

 