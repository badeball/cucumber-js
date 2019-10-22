Feature: Unambiguous Keywords

  Scenario:
    Given a file named "features/a.feature" with:
      """
      Feature: a feature name
        Scenario: a scenario name
          Given a step
      """
    Given a file named "features/step_definitions/cucumber_steps.js" with:
      """
      import {When} from 'cucumber'

      When(/^a step$/, function() {});
      """
    When I run cucumber-js with `-f progress`
    Then it outputs the text:
      """
      A

      Failures:

      1) Scenario: a scenario name # features/a.feature:2
         ✖ Given a step
             A step with wrong keyword match:
               /^a step$/ - features/step_definitions/cucumber_steps.js:3

      1 scenario (1 wrongly typed)
      1 step (1 wrongly typed)
      <duration-stat>
      """
    And it fails

  Scenario:
    Given a file named "features/a.feature" with:
      """
      Feature: a feature name
        Scenario: a scenario name
          Then a should hold
          And b should also hold
      """
    Given a file named "features/step_definitions/cucumber_steps.js" with:
      """
      import {Then, When} from 'cucumber'

      Then(/^a should hold$/, function() {});
      When(/^b should also hold$/, function() {});
      """
    When I run cucumber-js with `-f progress`
    Then it outputs the text:
      """
      A

      Failures:

      1) Scenario: a scenario name # features/a.feature:2
         ✖ Given a step
             A step with wrong keyword match:
               /^b should also hold$/ - features/step_definitions/cucumber_steps.js:4

      1 scenario (1 wrongly typed)
      1 step (1 wrongly typed)
      <duration-stat>
      """
    And it fails

  Scenario:
    Given a file named "features/a.feature" with:
      """
      Feature: a feature name
        Scenario: a scenario name
          Then a should hold
          But b should not hold
      """
    Given a file named "features/step_definitions/cucumber_steps.js" with:
      """
      import {Then, When} from 'cucumber'

      Then(/^a should hold$/, function() {});
      When(/^b should not hold$/, function() {});
      """
    When I run cucumber-js with `-f progress`
    Then it outputs the text:
      """
      A

      Failures:

      1) Scenario: a scenario name # features/a.feature:2
         ✖ Given a step
             A step with wrong keyword match:
               /^b should not hold$/ - features/step_definitions/cucumber_steps.js:4

      1 scenario (1 wrongly typed)
      1 step (1 wrongly typed)
      <duration-stat>
      """
    And it fails
