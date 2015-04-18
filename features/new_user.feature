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

    Given these units:
      | unit   | conversion_factor  | 
      | cup    | 5                  |
      | liter  | 10                 |

    Given these recipes:
      | name           |    directions            | Ingredients                 | cooking_time |
      | Toast and Jam  | Put jam on toast         | Honey 1 cup, Jam 1 liter    |  7           |
      | Scrambled Eggs | Eggs then milk, scramble | Eggs 4 cup, Milk 1 liter    |  20          |
      | Cereal         | Milk first, then cereal  | Cereal 1 cup, Milk 1 liter  |  10          |

#  Scenario: signing in with git hub
#    Given I am on the recipes page
#    When I press "Login"
#    Then I press "Sign in with Github"
#    Then I should see "jkrth617"

  Scenario: Signing in with Devise
     Given I am on the recipes page
     Then I should see "Welcome"
     And I should see "Login"
     But I should not see "Sign Out"
     Then I press "Login"
     And I sign in
     Then I should see "jd.roth"
     And I should see "Sign Out"
     But I should not see "Login"