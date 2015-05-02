Feature: User "cooking"
  As a chef,
  so that I can figure out what recipes I can cook with my ingredients,
  I want to be able to see what recipes have ingredients close to my groceries!

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
      | Toast and Jam  | Put jam on toast         | Honey 2 cup, Jam 2 liter, Eggs 3 cup     |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 2 liter, Jam 2 liter    |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 2 cup, Milk 2 liter, Honey 2 cup  |  10          |

    Given a user with these groceries:
      | groceries                |
      | Honey 5 cup              |
      | Jam 5 liter              |
      | Milk 5 liter             |
      | Cereal 5 cup             |
      | Eggs 5 liter             |


  Scenario: I should be able to cook recipes that I have sufficient ingredients for
    When I view my fridge
    Then I press "What can I cook?"
    Then I should be on the cookable recipes page
    And I should see that I can cook "Toast and Jam"
    And I should see that I can cook "Scrambled Eggs"
    And I should see that I can cook "Cereal"

  Scenario: I should not be able to see recipes for which I am lacking more than two ingredients
    When I view my fridge
    And I press "Update fridge!"
    Then I fill in "oldgrocs[groc[grocery_2]]" with "1"
    Then I fill in "oldgrocs[groc[grocery_5]]" with "0"
    Then I press "Update Fridge!"
    Then I press "What can I cook?"
    Then I should be on the cookable recipes page
    And I should see that I can cook "Cereal"
    And I should see that I am missing "1 Jam, 3 Eggs" in order to make "Toast and Jam"
    And I should see that I am missing "4 Eggs, 1 Jam" in order to make "Scrambled Eggs"

  Scenario:  I should see recipes that I cannot cook display the number of missing ingredients
    When I view my fridge
    And I press "Update fridge!"
    Then I fill in "oldgrocs[groc[grocery_1]]" with "1"
    Then I fill in "oldgrocs[groc[grocery_2]]" with "1"
    Then I fill in "oldgrocs[groc[grocery_3]]" with "1"
    Then I fill in "oldgrocs[groc[grocery_4]]" with "1"
    Then I fill in "oldgrocs[groc[grocery_5]]" with "0"
    Then I press "Update Fridge!"
    Then I press "What can I cook?"
    Then I should be on the cookable recipes page

  Scenario:  I should see recipes that I cannot cook display the number of missing ingredients
    When I view my fridge
    And I press "Update fridge!"
    Then I fill in "oldgrocs[groc[grocery_1]]" with "0"
    Then I press "Update Fridge!"
    Then I press "What can I cook?"
    Then I should be on the cookable recipes page





