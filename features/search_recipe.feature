Feature: Search recipes by name
  As a chef,
  so that I can quickly find recipes by keyword,
  I want to be able to search recipes by name.

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
      | New Toast      | Get a new toaster        | Honey 2 cup, Jam 1 liter    |  4           |



  Scenario: search for a recipe by name
    When I go to the recipes page
    And I fill in "Recipe name" with "Toast"
    And I press "Search Recipes"
    Then I should be on the recipes page
    And I should see "New Toast"
    And I should see "Toast and Jam"
    But I should not see "Cereal"
    And I should not see "Scrambled Eggs"

  Scenario: search results should last
    When I go to the recipes page
    And I fill in "Recipe name" with "Toast"
    And I press "Search Recipes"
    And I press "New Toast"
    Then I press "Back to recipes!"
    Then I should be on the recipes page
    And I should see "New Toast"
    And I should see "Toast and Jam"
    But I should not see "Cereal"
    And I should not see "Scrambled Eggs"

  Scenario:  Gibberish search should return helpful message
    When I go to the recipes page
    And I fill in "Recipe name" with "Lava Cake"
    And I press "Search Recipes"
    Then I should be on the recipes page
    And I should see "No recipes found"
    And I should see "New Toast"
    And I should see "Toast and Jam"
    But I should see "Cereal"
    And I should see "Scrambled Eggs"