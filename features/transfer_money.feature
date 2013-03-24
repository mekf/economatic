Feature:
  In order to pay money to other people in the system
  As an account operator
  I want to be able to transfer money to another account

  Background:
    Given a bank
    Given account FrodoSavings
    Given account BilboChecking
    Given a user Gandhalf who can operate FrodoSavings account

  Scenario: Succesfully transfer money
    When Gandhalf transfers $50 from FrodoSavings account to BilboChecking account
    Then FrodoSavings account has a balance of $-50
    Then BilboChecking account has a balance of $50
    Then FrodoSavings account has a $50 transaction by Gandhalf to BilboChecking account in the transaction log
    Then BilboChecking account has a $50 transaction by Gandhalf from FrodoSavings account in the transaction log

  Scenario: Restrict access to accounts
    Given a user Gollum who can not operate FrodoSavings account
    When Gollum transfers $50 from FrodoSavings account to BilboChecking account an error should be raised
    Then FrodoSavings account has a balance of $0
    Then BilboChecking account has a balance of $0

  Scenario Outline: Overdraft limits
    Given FrodoSavings account has an overdraft limit of <overdraft_limit>
    When Gandhalf transfers <transfer_amount> from FrodoSavings account to BilboChecking account <error>
    Then FrodoSavings account has a balance of <frodo_balance>
    Then BilboChecking account has a balance of <bilbo_balance>

    Examples:
    | overdraft_limit | transfer_amount | frodo_balance | bilbo_balance | error                         |
    | $-30            | $50             | $0            | $0            | an error should be raised     |
    | $-30            | $20             | $-20          | $20           | an error should not be raised |