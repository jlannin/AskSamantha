Feature: User "fridges"
  As a chef,
  so that I can record what groceries I currently have,
  I want to be able to view the groceries currently in my fridge.

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
      | name           |    directions            | Ingredients                 | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 1 cup, Jam 1 liter    |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 1 liter    |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1 cup, Milk 1 liter  |  10          |

    Given a user with these groceries:
      | groceries                |
      | Honey 3 cup              |
      | Jam 1 liter              |

  Scenario: View fridge while not logged in
    When I go to the show_fridge page
    Then I should see "Login to view your fridge!"

  Scenario: View fridge while logged in
    When I view my fridge
    Then I should see that "Honey" has a quantity of "3 cups"
    Then I should see that "Jam" has a quantity of "1 liter"

  Scenario: Updating grocery item
    When I view my fridge
    And I press "Update fridge!"
    Then I select "Milk" for grocery "1" food
    Then I select "teaspoon" for grocery "1" unit
    Then I press "Update Fridge!"
    Then I should see that "Milk" has a quantity of "3 teaspoons"
    Then I should see that "Jam" has a quantity of "1 liter"
    And I should not see "Honey"
    And I should not see "cup"

  Scenario:  Deleting a grocery item
    When I view my fridge
    And I press "Update fridge!"
    Then I fill in "oldgrocs[groc[grocery_1]]" with "0"
    Then I press "Update Fridge!" 
    Then I should see that "Jam" has a quantity of "1 liter"
    But I should not see "Honey"
    Then I press "Update fridge!"
    Then I press "Delete grocery"
    Then I press "Update Fridge!" 
    Then I should not see "Honey"
    And I should not see "Jam"

  Scenario: Adding new groceries
    When I view my fridge
    And I press "Update fridge!"
    Then I press "Add grocery"
    Then I select "Milk" for new grocery "1" food
    Then I select "teaspoon" for new grocery "1" unit
    Then I fill in "newgrocs[new_grocs[newgrocery_1]]" with "10"
    Then I press "Update Fridge!"
    Then I should see that "Milk" has a quantity of "10 teaspoons"
    Then I should see that "Jam" has a quantity of "1 liter"
    Then I should see that "Honey" has a quantity of "3 cups"





