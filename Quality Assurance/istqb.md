# [ISTQB](https://www.istqb.org/)

ISTQB stands for International Software Testing Qualifications Board, and is the leading global certification scheme in the field of software testing.

The complete [syllabus v4.0](https://istqb-main-web-prod.s3.amazonaws.com/media/documents/ISTQB_CTFL_Syllabus-v4.0.pdf) is, the Foundation Level is the first row:

![[Pasted image 20231129223528.png]]

## Fundamentals of Testing

### Testing Principles

1. **Testing shows the presence, not the absence, of defects.** It can only lower the probability.
2. **Exhaustive testing is impossible.** Focus on test techniques, test case prioritization, and risk-based testing.
3. **Early testing saves time and money** by removing them as early as possible, preventing cascading.
4. **Defects cluster together.** A few components usually contain most of the defects.
5. **Tests wear out.** Being repeated makes tests increasingly ineffective in detecting new defects. They should be reviewed, test data changed, and or new tests written to increase coverage. This does not apply to automated regression testing.
6. **Testing is context dependent.** There is no universally applicable approach to testing.
7. **Absence-of-defects fallacy.** Software verification does not ensure a successful product. Validation must also be carried out with the end-user and customer. 

### Activities and Tasks

- Planning — defining objectives and approach.
- Monitoring and control — ongoing checking and taking actions to meet the planned objectives.
- Analysis — what to test, in terms of measurable coverage criteria.
- Design — how to test. Includes defining test cases and testware requirements (e.g., test data), designing the test environment, and identifying any other required infrastructure and tools.
- Implementation — creating and/or acquiring the tests and testware, planning the execution schedule, and building and verifying the test environment.
- Execution — running tests according to the schedule (test runs), comparing test results with the expected results, analyzing anomalies to identify likely causes, and reporting the results.
- Completion — usually at project milestones. Testware is archived or handed over to appropriate teams. The test environment is shutdown to an agreed state. Test activities are analyzed for lessons learned, and a completion report is created and communicated to the stakeholders.

### Contexts and Factors

- Stakeholders — needs, expectations, requirements, willingness to cooperate.
- Team members — skills, knowledge, level of experience, availability, training needs.
- Business domain — criticality of the test object, identified risks, market needs, legal regulations.
- Technical factors — type of software, product architecture, technology used.
- Project constraints — scope, time, budget, resources.
- Organizational factors — organizational structure, existing policies, practices used.
- Software development lifecycle — engineering practices, development methods.
- Tools — availability, usability, compliance.

### Testware

Testware is created as output work products from test activities

TO-DO

---

## Testing Throughout the SDLC — Software Development LifeCycle

### SDLC Models

A systematic plan that defines the developing process.
What? Who? When? How?

A ***model*** that describes the types of ***activity*** performed at each ***stage*** in a software development project, and how the activities relate to one another logically and ***chronologically***.

#### Stages / Phases

![[Pasted image 20231130080648.png]]

#### Types

- Sequentia —  Waterfall, V-Model
- Iterativ —  Rational Unified Process (RUP), Agile (Scrum, Kanban), Spiral

##### Waterfall (Sequential)

![[Pasted image 20231130081015.png]]

Cons:
- Slow and inefficien —  waiting on others to finish their part.
- Any stage can become a bottleneck.
- (Very) late feedback.

![[Pasted image 20231130081428.png]]

##### V-Model (Sequential)

![[Pasted image 20231130081535.png]]

Testing throughout the lifecycle.

##### Iterative Models

Timeboxed periods to deliver subsets of functionality.

- Rational Unified Process (RUP)
- Agile 
	- Scrum
	- Kanban
- Spiral

Difference:
![[Pasted image 20231130081935.png]]
![[Pasted image 20231130082043.png]]

### Test Levels

 Four test levels:
 - Component (Unit) - how a single component/unit works.
 - Integration - how components interact when connected.
 - System - how all components as a whole work.
 - Acceptance - testing with the end-user / customer.

![[Pasted image 20231130082838.png]]

![[Pasted image 20231130082920.png]]

#### Component Test Level

Component / Unit / Module testing focuses on components that are separately testable.  

![[Pasted image 20231130083412.png]]

#### Integration Test Level

Testing if two or more units work coreectly together.

Book: Unit Testing Principles, Practices, and Patterns.

![[Pasted image 20231130083448.png]]
![[Pasted image 20231130083524.png]]

##### Component Integration

Testing between the components within the same system.

##### System Integration

Tests between subsystems, databases, infrastructure components, APIs, microservices.

Test basis:
- Technical specs
- Design documents
- Sequence diagrams
- Public interface definitions

#### System Test Level

Start by testing a system against the outside boundaries.
Next, you test the system flows — the important paths through the system.

E2E — End to End
F2B — Front to Back

![[Pasted image 20231130092048.png]]


#### Acceptance Test Levels

Testing with the end-user, so the customer can accept the product.
Validating that the product works as required, and is complete.
Essential to work with clear and complete requirements.

UAT — User Acceptance Testing: user's being able to use the software for their needs.

OAT — Operational Acceptance Testing: testing operations like: 
- Back-up and restore
- Installing and uninstalling, upgrading.
- Disaster recovery
- Data load and migration
- Performance and load testing in real-world scenarios.

Alpha testing happens on the developer's site.
Beta testing happens at the site of the customer, on their infrastructure (computers, servers).

#### Summary

![[Pasted image 20231130102528.png]]

### Test Coverage

Functional Coverage — the degree to which an application is exercised by tests as a percentage.
Coverage Gap — the percentage of the application that is not tested.

![[Pasted image 20231130103817.png]]

### Impact Analysis

When a change to the software is made, this can have regression — unintended side effects. To identify which parts of the software are affected, an Impact Analysis can be performed.

Answering the questions:
- What has changed?
- Where in the system is the change?
- Which parts are definitely impacted?
- Which parts are likely to be affected?

Things to watch out for:
- Outdated specifications — have discussions with people who have been on the project for some time to compensate this.
- Lack of knowledge — there might not be enough knowledge left in the team in a long-running project due to people leaving.
- Outdated tests with no traceability.
- Weak or non-existing tool support.

### Test Types / Groupings

A test can be a combination of several types.
Communicate the type of test depending on what you are focussing on.
Companies can also have their own groupings.

![[Pasted image 20231130111246.png]]

#### Functional Testing

Answers the “What?” questions. Checking the functional completeness, functional correctness, and the functional appropriateness.

Does the feature *function* correctly?
Does it *work* as expected?

![[Pasted image 20231130103102.png]]

#### Non-functional Testing

Answers the “How?” questions: how well, fast, stable, usable, secure?

The [ISO/IEC 25010](https://www.iso.org/obp/ui/#iso:std:iso-iec:25010:ed-2:v1:en) standard provides the following classification of the non-functional software quality characteristics:
- Performance efficiency
- Compatibility
- Usability
- Reliability
- Security
- Maintainability
- Portability

The main ones are:
![[Pasted image 20231130104407.png]]

##### Usability Testing

May be achieved via alpha and beta testing.
How well can the end-user use the software.

##### Performance Testing

Specialist area that requires special tools.

Types:
- Stress Testing
- Load Testing
- Endurance Testing
- Scalability Testing
- Spike Testing

##### Security Testing

Huge specialist domain. Separate career path, not typically done by QA Testers.

Types:
- Penetration Testing (Pen testing)
- Ethical Hacking
- White-hat Hacking

#### Blackbox vs. Whitebox Testing

Other way of classifying tests.

##### Blackbox Testing

You test a system (SUT — System Under Test) by sending input the outside boundaries of the system and checking the output, certain environment variables, and the timing against the system requirements.

![[Pasted image 20231130105226.png]]

##### Whitebox Testing

Carrying out tests knowing what the SUT consists of, like Unit Tests carried out by developers.
It is also carried out by sending input and checking the output against requirements, and also technical specs, but on a smaller level.

#### Change-related Testing

Testing after:
- Bug fix
- New feature
- Change to existing feature
- Configuration and environmental changes (e.g., in infrastructure)

##### Confirmation Testing

Is the bug really fixed?

Re-run the tests that failed before the fix, or also by adding new tests that cover any changes made to fix the bug.
Or simply by exercising the steps to reproduce the bug and confirm it has been fixed.

##### Regression Testing

Does the fix or change break anything else?

Regression — any unintended side effect caused by a change.

![[Pasted image 20231130110412.png]]

Perform an Impact Analysis — identifying which parts of the software could be affected by the change, and re-run the tests for all those parts and testing levels.

Regression tests increase in number with each software iteration, and need to be executed a lot, so automate as much as possible to make the process faster.

#### Maintenance Testing

For changes after deployment. Can be done with the help of an Impact Analysis.

Change categories:
- Unplanned
	- Bugs or failures in production.
	- A required hotfix.
- Planned
	- Software enhancements, feature drops.
	- Operational and environmental upgrades, like migration to newer version of a used tech.
	- Retirement of out-dated or unsafe tech, requiring a rewrite to be able to use newer tech.

---

## Static Testing

Static testing examines software work products to find defects early in the lifecycle, before something goes wrong, and doesn't involve code execution.

Compliments dynamic testing as it finds different defects.

Work products that can be examined in static testing include:
- Business requirements
- Architecture and design specifications
- Epics, user stories, acceptance criteria
- Code
- Web pages
- User guides

### Manual Techniques

In order of increasing formality:
- Informal reviews
- Walkthroughs 
- Formal technical reviews
- Software inspection

### Tool-based Techniques

- For any work products with structure, e.g., code.
- Important for safety critical system, e.g., pre-flight checks before an airplane takes off.
- Security testing.
- Incorporated into automated processes, e.g., build and delivery systems.

![[Pasted image 20231130142353.png]]

### Reviews

Reviews are static testing techniques used early in the lifecycle to identify potential defects in work products.

[ISO/IEC 20246](https://www.iso.org/obp/ui/#iso:std:iso-iec:20246:ed-1:v1:en)

#### Review Process

![[Pasted image 20231130144518.png]]

#### Review Roles

- Author — creates the work product and addresses the issues.
- Review Leader — has overall responsibility, selects participants, organizes the meetings.
- Facilitator / Moderator — leads the meetings, and mediates different viewpoints.
- Reviewers — technical guru, project staff, or business expert.
- Scribe / Recorder — keeps track of issues.
- Management — responsible for planning, decides strategy, assigns staff budget and time, monitors cost-effectiveness, and executes control decisions.

---

## Test Analysis and Design (Test Techniques)

### Experience-based Testing

Making use of experience of testers, developers, end-users, and stakeholders, working on or using similar software, to guide the testing efforts.

### Blackbox Test Techniques

Focus on inputs and outputs of the SUT — System Under Test.

#### Equivalence Partitioning

Identifying different parts in a test case, and defining whether that is an invalid or valid partition.
A test can then be written for all different parts.
This massively reduces the number of test cases required, but will slightly reduce defect detection.

*Example:*
![[Pasted image 20231130160330.png]]
This gives three tests, instead of testing for all amounts of chars in the valid partition:
1. Less than 6 chars.
2. From 6 up to 99 chars (between is ambiguous)
3. More than 100 chars.

Use a number line, like in the example, when working with numbers to better visualize what to test.

For choosing the input values to test with, one random value can be picked for each partition. However, a better approach is using Boundary Values, if the partitions are ordered — meaning with numbers or time.

#### Boundary Value Analysis

Behavior at the boundaries of equivalence partitions is more likely to be incorrect than the behavior within the partitions.
Using boundary test values increases the likelihood of defect detection.

Two point - on the boundary, and just outside the boundary:
![[Pasted image 20231130162155.png]]

Three point — on the boundary, and just outside and inside the boundary:
![[Pasted image 20231130162251.png]]

#### Decision Table Testing

A ***Decision Table*** displays business logic in a concise and readable way, and consists of rows that each contain a Condition or Action.

A ***Condition*** is something that affect the processing of an entity, and may affect which action is taken.

An ***Action*** is an observable result that is used to verify the expected behavior.

The order of Condition rows doesn't matter, but should be above Action rows.

![[Pasted image 20231130173355.png]]

To get all test cases, fill in the table like a truth table (waarheidstabel). Each possible combination of condition results should be covered.

*Example*:
![[Pasted image 20231130173604.png]]

#### State Transition Testing

Often used for menu-based applications and screen navigation testing.
Not suitable for larger systems or systems with non-sequential inputs.

*Example ATM application valid states, transitions, and events:*
![[Pasted image 20231130175658.png]]
*Boxes are states, arrows are transitions, text next to arrows are events.*

![[Pasted image 20231130175754.png]]

![[Pasted image 20231130180052.png]]
*All dashes are invalid states.*

Coverage is measured as the number of identified states or transitions tested, divided by the total number of identified states or transitions, expressed as a percentage.

#### Use Case Testing

A use case describes a specific way of interacting with a system.

![[Pasted image 20231202104819.png]]

High level, useful for identifying integration defects, and exercising business rules.

Pre-conditions need to be met for a use case to work successfully. For example, a user needs to be logged in and assigned a role in the system.

Post-conditions need to be met after a use case is completed. For example, a row has been created in the database, a flag field set to true, and a notification of the event has been sent.

Use Case Scenarios can cover basic behaviors as well as exceptional behavior and error handling.

![[Pasted image 20231202104912.png]]


### Whitebox Test Techniques

On the Component Test level.

#### Statement Testing

Exercises the executable statements in the code within a component.

*Example:*
![[Pasted image 20231202105617.png]]
*The marked code are the executable statements.*

*Same example as a flowchart:*
![[Pasted image 20231202105754.png]]

100% statement coverage means all executable statements are covered by test cases. In the example, that means we need two test cases. We don't need a test case for a cone that does not have sauce (true > false).

#### Decision Testing

Tests the code based on decision outcomes. Exercising the decisions in the code. 

![[Pasted image 20231202110210.png]]

100% decision coverage means all decision outcomes are covered by test cases. In the example, that means we require three test cases. The same two as in statement coverage, but with an extra one covering the test case for a cone that does not have sauce.

100% decision coverage guarantees 100% statement coverage.
(Not vice versa.)

### Experience-based Test Techniques

![[Pasted image 20231202111059.png]]

Experience based test techniques. Utilizing the experience of different people, like Testers, Developers, Users, and Stakeholder.

![[Pasted image 20231202111204.png]]

#### Error Guessing

Error Guessing involves creating tests to expose failures that are likely to occur within a certain context.
It attempts to predict the occurrence of defects, errors, and failures.

Creating more or extra tests, focussing on problem areas that are known from previous development — from experience.

For example, a developer might have worked on an app for children before, and when developing another app for children, can guess some of the issues that will occur when the target audience of children interacts with the app. So, testing can focus on these known issues.
The same goes for working with certain technologies or third party services. Testing can focus extra on known issues from experience.

This experience is defined in three *Data Sources*:
- Past Experience (main data source)
- General Causes of Software Failure (for desktop or mobile apps)
- Defect & Failure Data (e.g., contradictory system requirements)

A list of likely defects, errors, and failures, can be used to make the technique of Error Guessing more methodically and structured.

#### Checklist-based Testing

The use of a checklist to provide guidelines of what to test. Providing consistency and ensuring important aspects of the test object are not missed.

Less specific checklist items will result in more variability in the tests performed.

The data source for these checklist items can be the same as with Error Guessing, with the addition of non-functional things that are significant to users (User Data).

Can be re-used on different projects and for various test types.

Likely to increase test coverage, but decrease repeatability.

#### Exploratory Testing

Iterative process that starts with Exploring, while also Documenting their findings. The findings are then Reviewed and used to create tests for areas that need more testing, and it is decided where, or where not, to focus testing in the next iteration.

Tests are not pre-defined. Commonly used within reactive test strategies.

![[Pasted image 20231202113936.png]]

Tests are designed, executed, logged, and evaluated during test execution.

##### Session-based Exploratory Testing

A way of structuring Exploratory Testing within a fixed timeframe, guided by a test charter, and documented in session sheets.

![[Pasted image 20231202114320.png]]

![[Pasted image 20231202114450.png]]

Ideal for when there is only limited documentation available, or there are time constraints.

---

## Managing the Test Activities (Test Management)

### The Test Manager

Writes the testing plan, the test policy, and test strategy, that answer the following questions:

Why test? — To avoid customer dissatisfaction, non-compliance to regulations, and damage to the organizations' reputation.
What? — Focus on critical high risk parts of the product.
When? — Start as early as possible. Manages scheduling and preparation.
Where? — On a production equivalent test environment.
How? — 

![[Pasted image 20231203173510.png]]

#### Test Policy

A brief, concise document describing why you most test on organizational level.
- Outlines the test process.
- How testing will be evaluated.
- Quality levels.
- Process improvement.

![[Pasted image 20231203174331.png]]

#### Test Strategy

A detailed document describing what you should test, and what not to test, depending on the context.
- Scope — what is included and excluded for reasons of budget, difficulty to test, or low risk?
- People — what is the team like? Special training needed? 
- Approach — Risk based? Manual or automated?
- Criteria — When is the testing done? What are the exit criteria?
- Environment — Where will the tests be run?

![[Pasted image 20231203174855.png]]
*Examples: Space rockets and Bank*

##### Test Strategies:
- Analytical — risk based testing. More risk means more tests.
- Model-based — based on a business or state model.
- Methodical — systematic use of pre-defined tests. With common failure types, checklist of quality characteristics (reliability, portability, maintainability), standards for web pages and apps.
- Process compliant — based on rules and standards.
- Directed (or consultative) — driven by stakeholders or business experts' advice.
- Regression averse — uses extensive test automation.
- Reactive — requires tests to be written during test execution, like exploratory testing.

#### Test Environment

In a production environment, or on a desk computer?
Use live data, or a test data generator tool?
Set a budget and agree with the product manager and/or owner.

![[Pasted image 20231203180039.png]]

![[Pasted image 20231203180156.png]]

#### How Are Tests Carried Out?

- Manual or automated
- Acquire resources — select the right people for the job
- Support tool selection

- Defect management
- Configuration management
- Introduce metrics to monitor and control progress

- Initiate the testing
- Monitor progress
- Check exit criteria
- Report
- Adapt plans

### The Tester

- Review and contribute to the test plan.
- Analyse and review the test basis.
- Document test conditions.
- Capture traceability.

- Design test environment.
- Reserve test lab if necessary.
- Co-ordinate with system administrators to provide necessary access to testers.

- Identify test conditions.
- Design and implement test cases and procedures.
- Build the test data.
- Prepare the test data.

- Create the test execution schedule.
- Execute tests.
- Use appropriate tools.
- Automate some tests.

- Consider the non-functional requirements.
  [ISO/IEC 25010](https://www.iso.org/obp/ui/#iso:std:iso-iec:25010:ed-2:v1:en) Classification of software product quality characteristics.
  ![[Pasted image 20231203213738.png]]
  
#### Specialist Roles

- Technical Test Analyst
- Test Automation Engineer
- Performance Tester
- Security Specialist
- Pen(-etration) Tester

![[Pasted image 20231203213946.png]]

#### Independent Testing

- Can you find defects in your own work?
- A degree of tester independence is useful.
- Independence does not replace familiarity.

![[Pasted image 20231203214233.png]]

![[Pasted image 20231203214357.png]]

[ISO/IEC 29119-1](https://www.iso.org/standard/81291.html) Information about software testing concepts.

### Product Risk Analysis

...

### Managing Defects

A *Defect* is a manifestation of an error in the software.
#### Defect / Incident Report

Contains:
- ID
- Title
- Summary
- Date
- Organization
- Author
- Identification of the test item.
- Status, e.g., new, open, fixing, reject, deferred, ready, retest, reopen, closed.
- Lifecycle phase
- Test environment
- Detailed description of how to reproduce the problem, logging the expected and actual result.
- Change history and references.
- Global issues
- Conclusions, recommendations, and approvals.

Standard ISO/IEC/IEEE 29119-3

### How to Write a Test Plan

Test Plan — How is testing carried out?

![[Pasted image 20231214102924.png]]
UAT = User Acceptance Testing

#### Test planning activities

1. Determine the scope.
2. Choose an approach.
3. Integration and coordination.
4. Make decisions about whom, what, and how.
5. Scheduling.
6. Metrics.
7. Budgeting.
8. Templates.

Test Planning ISO/IEC/IEEE 29119-3

#### Entry and Exit Criteria

![[Pasted image 20231214104556.png]]

Test Entry Criteria examples:
- Availability of requirements, user stories, and models.
- Availability of test items, a test database, and test data.
- Test environments set up and ready.
- Test tools installed and available for use.

Test Exit Criteria examples:
- Planned tests have been run.
- Coverage level achieved.
- Unresolved defects.
- Remaining defects low.
- Level of quality characteristics.

### Applying Estimation Techniques

Account for dependencies between tests.
For example, if one test creates a database entry, and another test deletes it, the former should run first.

You must balance efficiency of test execution with the test priority.

Hofstadter's Law — It always takes longer than you expect, even when you take into account Hofstadter's Law.

Estimation Techniques:
- Metrics-based estimation
	- Planning Poker: whole team votes with 1, 2, 3, 5, 8, 13, or 21.
	- Wideband Delphi: experts meet till a consensus is reached.
- Expert-based estimation.

### Keeping Track of Progress

#### Test Monitoring

Test Monitoring — collecting information about test activities in order to provide feedback to all stakeholders on how testing is progressing.
Test Control — taking decisive action if progress isn't going according to plan.

Metrics are sets of numbers that give information about a particular process or activity.
Gather metrics and make them visible.

Common Test Metrics:
- Planned work done percentage.
- Test case execution, and amount of tests run, failed, passed, and rerun.
- Defect information — total defects found, fixed, failure rate, defect density, and confirmation test results.
- Coverage — percentage of features covered, user stories covered, acceptance criteria met, and code coverage.
- Task completion.
- Costs.
- Resource consumption.

Metrics can assess:
- Test approach.
- Quality of testing.
- Progress compared to schedule and budget.

#### Test Reporting

Two types:
- Test Progress Report — during testing.
- Test Summary Report — when exit criteria have been met.

Typical contents:
- Summary of testing performed.
- Information on what occurred during a test period.
- Deviations from the plan.
- Status of testing and product quality.
- Factors that block progress.
- Metrics.
- Residual risks.
- Reusable test work products produced that may be reused later or on other projects.

![[Pasted image 20231214113752.png]]

Standard for Testing Reports ISO/IEC/IEEE 29119-3


---

## Test Tools (Tool Support for Testing)

### Tool Types

![[Pasted image 20231214174257.png]]

#### Test Harness

Collection of Stubs, Drivers, and other supporting tools, for Component and Component Integration testing.

![[Pasted image 20231214173845.png]]

### Challenges and Benefits

![[Pasted image 20231214174852.png]]

### Potential Automation Risks

![[Pasted image 20231214175159.png]]
![[Pasted image 20231214175234.png]]
![[Pasted image 20231214175256.png]]



