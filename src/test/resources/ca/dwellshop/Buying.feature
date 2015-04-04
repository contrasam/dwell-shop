Feature: Buying a property

  Scenario: Interested in buying
    Given I am interested in buying a property
    When I click on buy property
    Then The seller of the property will be indicated that I am interested in buying the property


  Scenario: Property is sold
    Given I am a seller of a property
    When I indicate that the property is sold
    Then the property will appear as sold to all the users for 15 days