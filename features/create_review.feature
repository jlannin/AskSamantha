Feature: Create a new 
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

  Scenario: Creating a new review with no sign in
    Given I am on the recipes page
    When I press "Cereal"
    Then I should see "Write the first review"
    When I press "Write a Review"
    Then I sign in
    Then I should see "Welcome! You have signed up successfully."
    Then I should be reviewing "Cereal" on create new review page
    And I fill in "review_comments" with "Theyrrrree Greeeaat!"
    And I select "5" for rating
    And I press "Post Review"
    Then I should see "Review successfully created!"
    And I should see that the review with "Theyrrrree Greeeaat!" has a rating of "5"
    And I should see "jd.roth"

Scenario: Creating a new review with prev sign in
    Given I am on the recipes page
    Then I press "Login"
    Then I sign in
    Then I should see "Welcome! You have signed up successfully."
    When I press "Cereal"
    Then I review "Cereal" with "5"
    Then I should see "Review successfully created!"
    And I should see that the review with "Theyrrrree Greeeaat!" has a rating of "5"



Scenario: review(stars) should be on the index page
    Given I am on the recipes page
    Then I should see "Not yet rated!"
    And I should not see "★"
    Then I press "Login"
    Then I sign in
    When I press "Cereal"
    Then I review "Cereal" with "5"
    Then I should see "Review successfully created!"
    And I should see that the review with "Theyrrrree Greeeaat!" has a rating of "5"
    Then I press "Back to recipes"
    And I should see that the recipe "Cereal" has a rating of "5"

