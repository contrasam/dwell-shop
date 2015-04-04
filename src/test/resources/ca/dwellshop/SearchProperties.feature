Feature: Search Properties

  Scenario: Search based on text
    Given I have selected the region of search
    When I provide a search text and click on search
    Then I should be shown properties matching the search text

  Scenario: Filter properties based on property type
    Given I have selected the region of search
    When I choose a particular property type
    Then I should be shown properties only of that particular type

  Scenario: Filter properties based on number of rooms
    Given I have selected the region of search
    When I choose a particular number of rooms
    Then I should be shown properties only with the specified number of rooms

  Scenario: Filter properties based on price range
    Given I have selected the region of search
    When I select a minimum price and a maximum price
    Then I should b shown properties only within that price range