Feature: Create new product
  As the toy store manager,
  so that I can sell a variety of toys,
  I want to be able to add new toys to the toy store.

  Background: the toy story has several products
    Given these Products:
      | name         |    description     | price | 
      | slinky       | silvery and shiny  |  3.49 | 
      | fluffy bunny | fluffy and lovable | 17.50 | 
      | ball         | rubbery and round  | 13.49 | 

  Scenario: Create a new product without specific image
    Given I am on the create new product page
    When I fill in the following:
      | Name        | pointy stick         |
      | Description | pointy and dangerous |
      | Price       | 8.99                 |
    And I press "Create product"
    Then I should be on the products page
    And I should see "New product pointy stick created successfully"
    And I should see that "pointy stick" has a price of "$8.99"
    And I should see that "pointy stick" has an image "noimg.jpg"

  Scenario: Create a new product with specific image
    Given I am on the create new product page
    When I fill in the following:
      | Name        | pointy stick         |
      | Description | pointy and dangerous |
      | Price       | 8.99                 |
    When I attach the file "stick.jpg" to "Image"
    And I press "Create product"
    Then I should be on the products page
    And I should see "New product pointy stick created successfully"
    And I should see that "pointy stick" has a price of "$8.99"
    And I should see that "pointy stick" has an image "stick.jpg"
