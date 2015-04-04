Feature: Bidding on a property
  The users can bid on properties which are biddable

  Scenario: Bid on property above minimum bid amount
    Given I have selected a property to bid on
    When I provide the bidding amount higher than the minimum bidding price
    Then the bid would be placed for the property

  Scenario: Bid on property below minimum bid amount
    Given I have selected a property to bid on
    When I provide the bidding amount lower than the minimum bidding price
    Then I should be shown a error message stating that the bidding amount should be above the minimum bidding amount

  Scenario: Bidding window
    Given I am a seller of a property
    When I make the property as biddable
    Then The bidding window should be open for only three days


