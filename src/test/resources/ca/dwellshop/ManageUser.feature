Feature: Manage User

  Scenario Outline: Create Account
    Given I am a new user to Dwell Shop
    When I enter my personal details
    And I provide my <email_address> and <password>
    Then I should be shown a message as <message>

    Examples:
      | email_address | password | message |
      | "john.doe@mary.com" | "test@123" | "Account created successfully." |
      | "doe.john@mary.com" | "test@123" | "The provided email address already exists, try logging in." |
      | "john.doe@mary.com" | "was"      | "The password have to be at least eight characters long."     |
