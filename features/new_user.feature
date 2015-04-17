Feature: Create a new 
  As a chef,
  so that I can have my own account
  I want to be able to sign in.

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

#  Scenario: signing in with git hub
#    Given I am on the recipes page
#    When I press "Login"
#    Then I press "Sign in with Github"
#    Then I should see "jkrth617"
