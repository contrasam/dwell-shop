Feature: Manage User

  Scenario Outline: Create Account
    Given I am a new user to Dwell Shop
    When I enter my personal details
    And I provide my <email_address> and <password>
    Then I should be shown a message as <message>

    Examples:
      | email_address | password | message |
      | "john.doe@mary.com" | "test@123" | "Account created successfully." |
      | "penatibus.et.magnis@mauris.com" | "test@123" | "The provided email address already exists, try logging in." |
      | "new.john.doe@mary.com" | "test" | "The password have to be at least eight characters long."     |

  Scenario: Login success
    Given I am an exiting user
    When I provide a my email address and password
    Then I should be granted access to Dwell Shop

  Scenario: Login failure
    Given I am an exiting user
    When I provide a my email address and password
    Then I should be shown a message stating that the email address or password is incorrect