# Quality Assurance

## Courses and Resources

- [Zhimin Zhan - Test Automation coach](https://medium.com/@zhiminzhan)
- [JSON to C# converter](https://json2csharp.com/)
- [Ministry of Testing](https://www.ministryoftesting.com/search?q=test+heuristics+cheat+sheet
- [Testing Demo Websites](https://automationpanda.com/2021/12/29/want-to-practice-test-automation-try-these-demo-sites/)

### DDD & SpecFlow
- [API and Webpage for learning testing (refreshed every 10min.)](https://automationintesting.online/)
- [SpecFlow Online Gherkin Editor](https://app.specflow.org/gherkin-editor/)

- [Pluralsight: Behaviour Driven Development: The Big Picture — Marko Vajs](https://app.pluralsight.com/library/courses/behavior-driven-development-big-picture/table-of-contents)
- [Pluralsight: Behaviour Driven Development: Fundamentals — Kevin James](https://app.pluralsight.com/library/courses/behavior-driven-development-fundamentals/table-of-contents)
- [Pluralsight: Behaviour Driven Development with SpecFlow — Eugene Niemand](https://app.pluralsight.com/library/courses/bdd-specflow/table-of-contents)
- [YouTube: SpecFlow 2021 — Execute Automation](https://www.youtube.com/playlist?list=PL6tu16kXT9Po4w7VVPh6VGU7G7nm3fxZb)

- [A Beginner’s Guide to Behavior-Driven Development with SpecFlow - Enes Khun](https://medium.com/@enesku/a-beginners-guide-to-behavior-driven-development-with-specflow-83428ff78f0d)
- [SpecFlow Docs: Selenium with Page Object Model Pattern](https://docs.specflow.org/projects/specflow/en/latest/ui-automation/Selenium-with-Page-Object-Pattern.html)
- [SpecFlow with .NET 8.0](https://github.com/SpecFlowOSS/SpecFlow.VS/releases/tag/v2022.1.93-net8)

- https://www.youtube.com/watch?v=8tNlF6y00Zc&list=PL6tu16kXT9Pp3wrsaYyNRnK1QkvVv6qdI&index=42
- https://www.youtube.com/watch?v=HrYUzzKXpTs&list=PL6tu16kXT9Po4w7VVPh6VGU7G7nm3fxZb&index=7
- https://medium.com/capgemini-microsoft-team/specflow-a-few-tips-n-tricks-856aad261a25
- https://www.nuget.org/packages/SolidToken.SpecFlow.DependencyInjection#readme-body-tab
- https://docs.specflow.org/en/latest/Examples.html

### Selenium
- [Pluralsight: Selenium 4: The Big Picture — Andrejs Doronins](https://app.pluralsight.com/library/courses/selenium-4-big-picture/table-of-contents)
- [Pluralsight: Selenium 4 Fundamentals with C# — Marko Vajs](https://app.pluralsight.com/library/courses/selenium-4-fundamentals-c-sharp/table-of-contents)
- [YouTube: SeleniumConf Chicago 2023 playlist](https://www.youtube.com/playlist?list=PLRdSclUtJDYXDEsWI0vwBmJxW17NgsaAk)

### Xpath
- [Xpather Online Editor](http://xpather.com/)
- [Xpath _cheat sheet_](https://devhints.io/xpath)
- [SelectorsHub Xpath plugin](https://selectorshub.com/selectorshub/)
- [W3schools: Xpath Tutorial](https://www.w3schools.com/xml/xpath_intro.asp)
- [Udemy: XPath Tutorial from basic to advance level. The complete XPath course for Selenium — Sanjay Kumar](https://www.udemy.com/course/xpath-tutorial-from-basic-to-advance-level/?signupsuccess=1)

### Manual Testing
- [Article: Manual Testing Tutorial for Beginners - Jash Unadkat](https://www.browserstack.com/guide/manual-testing-tutorial)

### Others
- [Article: Website Accessibility Testing Checklist](https://www.browserstack.com/guide/website-accessibility-testing-checklist) 
- [Axe by deque - Accessibility Test Automation Tools](https://www.deque.com/axe/)
- https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
- [Software Testing QA Best Practives](https://www.altexsoft.com/blog/software-testing-qa-best-practices/)


---

## Introduction

QA — Quality Assurance — is a process-oriented, preventive approach that focuses on the implementation and improvement of processes. It works on the basis that if a good process is followed correctly, then it will generate a good product. QA applies to both the development and testing processes, and is the responsibility of everyone on a project.

While people often use the terms “testing” and “quality assurance” (QA) interchangeably, testing and QA are not the same. Testing is a form of quality control (QC).

QC is a product-oriented, corrective approach that focuses on those activities supporting the achievement of appropriate levels of quality. Testing is a major form of quality control, while others include formal methods (model checking and proof of correctness), simulation and prototyping.

Test results are used by QA and QC. In QC, they are used for fixing defects, while in QA they provide feedback on how well the development and test processes are performing.

---

## Behaviour Driven Development (BDD)

### Overview

Methodology to bridge the gap between the software product and the business requirements by making tests and test results business readable. Resulting in a shorter feedback loop.

![[Pasted image 20231206131722.png]]

The sooner bugs, or misinterpretations of the requirements, get found, the lower the cost to fix them.
![[Pasted image 20231206104505.png]]

![[Pasted image 20231206112024.png]]

#### BDD vs. TDD

![[Pasted image 20231206105338.png]]
![[Pasted image 20231206105523.png]]![[Pasted image 20231206131650.png]]

#### Benefits

- Reduced time to complete tasks.
- A lower number of production issues.
- The delivery process costs less money.
- Higher confidence in the quality of the product.
- Increased individual productivity and motivation through better collaboration.
- Increased knowledge of the product domain.

- Improved communication:
	- Clearer, more precise discussions.
	- A shared understanding across roles.
- Enhanced collaboration:
	- Involves all stakeholders early on.
	- Collective ownership ensures user-centric solutions.
- User-centric development:
	- Focus on user outcomes, not just features.
	- Ensure the product fits the market need.
	- Aligns team with user expectations.
- Reduced ambiguity:
	- Clear specifications minimize misinterpretations and reduce rework.
- Faster feedback loops:
	- Clearer scenarios and automation speeds up validation.
	- Teams detect issues earlier.
	- Encourages agile, iterative development.
- Enhanced customer satisfaction:
	- Ensures software meets user needs.
	- Minimizes production bugs.
	- Enhances end-user trust.
- Continuous improvement:
	- A mindset that encourages improvement.
	- Facilitates iterative development.
	- Encourages regular feedback.
	- Teams constantly refine and improve.

![[Pasted image 20231206111854.png]]

#### Phases

![[Pasted image 20231206105121.png]]

1. Discovery of User Stories ![[Pasted image 20231206110103.png]]![[Pasted image 20231206110152.png]]![[Pasted image 20231206105020.png]]
   
2. Formulation of Scenarios (in Gherkin) ![[Pasted image 20231206110347.png]]

3. Transforming Scenarios into Executable Specifications ![[Pasted image 20231206111138.png]]
   
   Automated scenarios have the dual purpose of serving as Tests, as well as being living, human-readable Documentation of how the software should work. Succeeding tests prove the Documentations correctness and vice versa. ![[Pasted image 20231206112805.png]]![[Pasted image 20231206113012.png]]

#### Tools

- Google Drawings, or Miro — for Example Mapping with collaborative boards and post-its.
- Behave Pro (Jira extension) — integrating BDD into the Jira environment. [Vid](https://app.pluralsight.com/course-player?clipId=3d4e03c3-f895-47b3-a16e-a41e1e0e7dd0)

#### BDD Frameworks

![[Pasted image 20231206112709.png]]

### Workflow

![[Pasted image 20231206133038.png]]

#### Roles — The Three Amigos

![[Pasted image 20231206133142.png]]

The roles collaborate, discuss, and refine. With the goal of having a shared understanding of the desired behavior.

##### Product Owner

Responsibilities:
- The business representative.
- Has a business or end-users' perspective.
- Creates the user stories.
- Brings clarity about what the business needs, and why.

Sometimes a Business Analyst if the Product Owner isn't available.

##### Developer

Responsibilities:
- Understands the described behavior, and implement it in code.
- Ensure the technical feasibility of the requirements.
- Can suggest alternative approaches based on technical constraints.
- Translate the desired behaviors into functional software.

##### Tester

Responsibilities:
- Validate that the implemented behaviors, by the developers, meet the acceptance criteria.
- Find edge cases, pitfalls, and other scenarios to ensure robustness.
- Collaborate closely with the Product Owner and Developers to clarify any ambiguities.
- Ensures correct behavior across scenarios, catching issues before they reach production.


#### User Story

A user story is a concise description of a feature.
They are the WHAT we want to achieve.

BDD transforms user stories into validated experiences, through involving all stakeholder, and ensuring a shared understanding.

Anatomy:
1. Title — a concise descriptor.
2. Role — who is the user?
3. Feature — what do they want?
4. Benefit — why do they want it?

*Example:*
![[Pasted image 20231206135126.png]]

#### Acceptance Criteria

Where user stories are the WHAT, acceptance criteria are the HOW we know it is achieved. They are the roadmap too success, by ensuring the user stories fulfill their promises. A tool for collaboration and building a shared understanding.

Traits:
- Clear and concise.
- Testable and focused on outcomes.
- Relevant to the user story.

![[Pasted image 20231206135706.png]]

*Example:*
![[Pasted image 20231206135729.png]]

*Example (more an epic than a user story though):*
![[Pasted image 20231206135833.png]]

#### Complete Workflow Example

1. Identifying the Roles![[Pasted image 20231206140852.png]]
   
2. Writing User Story by collaborating ![[Pasted image 20231206140928.png]]![[Pasted image 20231206141001.png]]

3. Deriving the Accpetance Criteria from the User Story ![[Pasted image 20231206141141.png]]
   
   Mockup of what this might look like: ![[Pasted image 20231206141315.png]]

---

### Gherkin

Syntax designed to be a non-technical and human-readable way of describing use cases in software. It is the language of BDD, in plain English, and a lot of others as well, that brings structure and predictability, and also serves as living documentation.

Try it out in the [SpecFlow Online Gherkin Editor](https://app.specflow.org/gherkin-editor/).

#### Components

![[Pasted image 20231206153028.png]]

1. Feature:
	- Describes a software feature.
	- Offers a broader context of the feature.
	- Sets the foundation for associated scenarios.

2. Scenario: Represent specific user journeys or use-cases of witch the steps are a part of.

3. Steps: A series of steps that detail the actions and outcomes.

#### Syntax

#####  Basis

``Feature:`` — feature title, optionally followed by a describtion on the next line.

``Scenario:`` — scenario title, optionally followed by a describtion on the next line.

``Given`` — describes the context or initial state (and object page).
``When`` — describes the (inter-)action that will cause a change in the system state.
``Then`` — describes the expected outcome, but only those observable by the user (not, for example, checking a database.)

``And`` / ``But`` — extends the previous description.

*Examples:*
![[Pasted image 20231204150412.png]]
![[Pasted image 20231206110952.png]]

##### Comments \#
![[Pasted image 20231206160601.png]]

##### Tags @
![[Pasted image 20231206160658.png]]

##### Tables | |
![[Pasted image 20231206160753.png]]

##### Scenario Outline:
![[Pasted image 20231206160906.png]]

##### Examples:
![[Pasted image 20231206161015.png]]

##### Background: 

- Keep it client focussed.
- Avoid complex states, unless they are essential to the clients understanding. It is a section to put things in the spotlight.
- Use higher steps for less important details.
- Use decriptive names and storytelling. E.g., real names instead of User. Create a captivating setup, but brief.
- Keep it concise.
- Move recuring `Given` statements that repeat over multiple Scenarios within the same Feature, to the Background section.

![[Pasted image 20231207081130.png]]

![[Pasted image 20231206161109.png]]

#### Scenario Best Practices

- Use descriptive titles. Avoid generic phrases.
- Prioritize business language. Use Ubiquitous Language with DDD.
- Use Background sparingly. It adds complexity.
	- Use only for common steps.
	- Scenario independence reduces defect risk.
- Utilize Scenario Outlines for repetitive scenarios to avoid duplication, and to enhance test coverage.
- Use consistent formatting and style.
	- Standardize scenario structures.
	- Use a consistent tense — preferably the present tense in Gherkin.

*Bad example:* ![[Pasted image 20231206210135.png]]
*Same example improved:* ![[Pasted image 20231206210228.png]]

#### Writing Scenarios

Focus on user behavior. Write what the user does, not how it is implemented and achieved by the system. For example, use `When they add the product ...` instead of `When they click an the add button ...`. So, don't give any technical details.

Use descriptive and explicit language. Use past tense instead of future tense, by using actions that have already taken place (reflects, adjusts, generated).

Use realistic examples between `".."`, for example, `"smartphone"` instead of `product`.

##### Happy Path

*An already good example:* ![[Pasted image 20231206210618.png]]

*Same example improved:* ![[Pasted image 20231206210709.png]]

Steps to convert into code: ![[Pasted image 20231206214212.png]]

Base for code: ![[Pasted image 20231206214308.png]]

##### Unhappy Path (Negative)

*Example:* ![[Pasted image 20231206211036.png]]



---

### [SpecFlow](https://docs.specflow.org/projects/specflow/en/latest/)

![[Pasted image 20231204150426.png]]

![[Pasted image 20231206213920.png]]

#### Getting Started

1. Install the SpecFlow Extension for Visual Studio:
   Extensions > Manage Extensions
2. Creating a SpecFlow project. Select .NET 6.0 in the project creation. Once created, update it to .NET 8.0 in the project properties.
3. Install the Selenium NuGet package. Optionally also the Support package.
4. Download the latest Stable win64 version of the Chrome Driver from [Chrome for Testing](https://googlechromelabs.github.io/chrome-for-testing/) . ![[Pasted image 20231206233410.png]]

5. Create a Web Driver Library to be used with Selenium.



#### Linking / Binding Tests

A step in PURPLE text highlights there is no definition for it.
1. Right-click > Define Step (Ctrl+B, D) to create the Step Definition for it.
2. Implement the step logic.
3. Build the project if the Feature file does not link to the Step Definition.
Once linked, the text should turn white, signaling the step definition is linked.


Base setup of the Step Definitions class:
```cs
[Binding]
public sealed class StepDefinitions
{
	private AutomationTestContext _ctx;

	[BeforeScenario]
	public void Init()
	{
		_ctx = new AutomationTestContext;
	}

	[Given(@"same text as in feature file")]
	public void Given...() {...}

	[When(@"same text as in feature file")]
	public void When...() {...}

	[Then(@"same text as in feature file")]
	public void Then...() {...}
}
```

#### Debugging

Debug by placing breakpoints in the Feature file and Debug from the Test Explorer. You can then step through to see what code is being executed.

You can also take a screenshot when a Test Error occurs through the  Scenario Context:
```cs
[AfterScenario]
public void AfterScenario()
{
    if(_scenarioContext.TestError != null)
    {
        WebBrowser.Driver.CaptureScreenShot(_scenarioContext.ScenarioInfo.Title);
    }
}
```

#### Parameters

To parameterize words in the Feature file, the word should simply be replaced with `(.*)` in the linked test. It is then automatically passed to the parameter(s) in the test function.
Once linked, the parameter word turns RED.

In the Feature file:
```gherkin
When there is motion in the kitchen
```

In the test:
```cs
[When(@"there is motion in the (.*)")]
public void WhenThereIsMotionInTheKitchen(string roomName)
{
	_ctx.TriggerState(new MotionSensor($"motion.{roomName}", true));
}
```

This `When` statement can be reused in different scenarios with different parameters, e.g.:
``` gherkin
When there is motion in the hallway
```

#### Step Argument Conversion

Instead of showing implementation details in the test, `[StepArgumentTransformation]`'s can be defined and used instead.

The given example shows the creation of a class instance:
```cs
[When(@"there is motion in the (.*)")]
public void WhenThereIsMotionInTheKitchen(string roomName)
{
	_ctx.TriggerState(new MotionSensor($"motion.{roomName}", true));
}
```

We can move this to a transformation (a `MotionSensorWithMotion` is a `MotionSensor` always set to `true` instead of a second parameter):
```cs
[Binding]
public class Transforms
{
	[StepArgumentTransformation]
	public MotionSensorWithMotion MotionSensorWithMotionTransform(string roomName)
	{
		return new MotionSensorWithMotion($"motion.{roomName}");
	}
}
```

We can then pass this as a parameter in the test function. Parameters passed from the Feature file will still be passed on, but now into the transformation function:
```cs
[When(@"there is motion in the (.*)")]
public void WhenThereIsMotionInTheKitchen(MotionSensorWithMotion sensor)
{
	_ctx.TriggerState(sensor); // sensor created by the transform
}
```


#### SpecFlow Data Tables

##### Scenario Outlines

Steps in the Feature file:
1. Convert the Scenario into a Scenario Outline.
2. Convert the parameter word into a table parameter by placing it between `<camelCase>`.
3. Add an Examples section with a data table.

``` gherkin
Scenario Outline: no announcements during quiet time
	Given it is before 5 AM
	When there is motion in the <roomName>
	Then there is no announcement

	Examples:
	| roomName |
	| kitchen  |
	| hallway  |
```

##### [Data Table Helpers](https://docs.specflow.org/projects/specflow/en/latest/Bindings/SpecFlow-Assist-Helpers.html)

###### Use Data from a Table

Example feature file:
``` gherkin
Scenario Outline: no announcements during quiet time
	Given time range is
	| StartTime | EndTime |
	| 5 AM      | 7 AM    |
	...
```

```cs
// StepDefinitions.cs
[Given]
public void GivenTimeRangeIs(Table table)
{
	var tr = table.CreateInstance<TimeRange>(); // For one row
	// OR
	foreach (var tr in table.CreateSet<TimeRange>()) {...} // For multiple rows
	...
}
```

Most build in types are already supported, but you can also use your own types, like in this example. The properties must have a public getter and public setter, and the names must match the table column names, though not exactly. Whitespacing and casing is ignored.
```cs
// TimeRange.cs
public class TimeRange
{
	public int StartTime { get; set; }
	public int EndTime { get; set; }
}
```

###### Dynamic

To avoid having to create data types just to read a table, dynamic objects can be used.
To use it with SpecFlow an additional NuGet package is needed: `SpecFlow.Assist.Dynamic`.

```cs
using SpecFlow.Assist.Dynamic;
...
dynamic data = table.CreateDynamicSet(); // Creates an list of the table data.
```

###### Comparing Table Data

Comparing tables with `CompareToInstance<T>` and `CompareToSet<T>`.

###### Aliasing

Aliasing, giving test writers the ability to use other table column names next to the property name. Needs to be attributed in the type class:
```cs
public class Employee
{
    public string FirstName { get; set; }
    public string MiddleName { get; set; }

    [TableAliases("Last[]?Name", "Family[]?Name")] // []? ignores whitespaces
    public string Surname { get; set; }
}
```

###### Extensions

If you have a custom type within a custom type you have to write your own conversion method, implementing the `IValueRetriever` or `IValueComparer` interfaces, that takes a string and converts it into the correct type, and call it within a `[BeforeTestRun]` hook:
```cs
public class ColorValueRetriever : IValueRetriever
{
	public virtual Color GetValue(string value)
	... return color;
```

```cs
[Binding]
public static class Hooks1
{
    [BeforeTestRun]
    public static void BeforeTestRun()
    {
        Service.Instance.ValueRetrievers.Register(new ColorValueRetriever());
        Service.Instance.ValueComparers.Register(new ColorValueComparer());
    }
}
```


#### [Scenario Context](https://docs.specflow.org/projects/specflow/en/latest/Bindings/ScenarioContext.html)

Gives access to extra functions, like setting a configuration in the Given step.
``` gherkin
Scenario: prompt on motion based on room and time of day
	Given the following config
		| Room Name | Time Of Day         |
		| kitchen   | 2023-04-06 06:59:59 |
		... more rows
	When there is motion in room at specified time
	Then my smart speaker prompted
	| Speaker Name    | Message                                | Sent                |
	| speaker.kitchen | Dishwasher is done, have you unloaded? | 2023-04-06 07:00:01 |
	... more rows
	And my smart speaker announced
	| Speaker Name    | Message               | Sent                |
	| speaker.bedroom | Remember to set alarm | 2023-04-06 21:00:01 |
	... more rows
	
```

In a Binding, you can access the Scenario Context via context injection.
```cs
[Binding]
public sealed class StepDefinitions(ScenarioContext scenarioContext)
{
	private AutomationTestContext _ctx;
	private readonly ScenarioContext _scenarioContext = scenarioContext;

	[BeforeScenario]
	public void Init()
	{
		_ctx = new AutomationTestContext;
	}

	[Given(@"the following config")]
	public void GivenTheFollowingConfig(Table table)
	{
		_scenarioContext["configs"] = table.CreateSet<MotionTestConfig>();
	}

	[When(@"there is motion in room at specified time")]
	public void WhenThereIsMotionInRoomAtSpecifiedTime()
	{
		foreach (var motionTestConfig in (
			IEnumerable<MotionTestConfig>
			)_scenarioContext["configs"])
		{
			_ctx.SetTime(motionTestConfig.TimeOfDay);
			_ctx.TriggerState(new MotionSensorWithMotion(motionTestConfig.RoomName));
		}
	}

	[Then(@"my smart speaker (.*)")]
	public void ThenMySmartSpeakerPrompted(AnnouncementType type, Table table)
	{
		switch (type)
		{
			case AnnouncementType.Prompted:
				table.CompareToSet(_ctx.Home.Prompts);
				break;
			case AnnouncementType.Announced:
				table.CompareToSet(_ctx.Home.Announcements);
				break;
			default:
				throw new ArgumentOutOfRangeException(nameof(type), type, null);
		}
	}
}
```

```cs
public sealed class BedroomAutomations
{
	public BedroomAutomations(MyHome home)
	{
		home.StateChanges.Where(s => s.Name == "motion.bedroom").Subscribe(_ =>
		{
			switch (home.CurrentTime.Hour)
			{
				case >= 23:
					return;
				case >= 21:
					home.Announce(new Announcement(
						"speaker.bedroom", "Remember to set alarm", home.CurrentTime));
					break;
			}
		});
	}
}
```

```cs
public class MotionTestConfig
{
	public string RoomName { get; set; }
	public string TimeOfDay { get; set; }
}
```

```cs
public enum AnnouncementType
{
	Prompted,
	Announced
}
```

We can also call the Scenario Context to get more info of what is going on in the steps, for example for logging and debug purposes.
```cs
// Scenario Info
var scenarioInfo = _scenarioContext.ScenarioInfo;
scenarioInfo.Title;
scenarioInfo.Tags;
scenarioInfo.CombinedTags;
scenarioInfo.Arguments;

var error = scenarioInfo.TestError;
error.Message;
error.GetType().Name;

// Step Info
var stepType = _scenarioContext.CurrentScenarioBlock.ToString(); // Given, When or Then

var stepInfo = _scenarioContext.StepContext.StepInfo;
stepInfo.StepDefinitionType;
stepInfo.Text;
```

#### [Hooks](https://docs.specflow.org/projects/specflow/en/latest/Bindings/Hooks.html)

Hooks (event bindings) can be used to perform additional automation logic at specific times, such as any setup required prior to executing a scenario.

|Attribute|Tag filtering*|Description|
|---|---|---|
|[BeforeTestRun]/[AfterTestRun]|not possible|Automation logic that has to run before/after the entire test run.  <br>**Note: As most of the unit test runners do not provide a hook for executing logic once the tests have been executed, the [AfterTestRun] event is triggered by the test assembly unload event.  <br>The exact timing and thread of this execution may therefore differ for each test runner.**  <br>The method it is applied to must be static.|
|[BeforeFeature]/[AfterFeature]|possible|Automation logic that has to run before/after executing each feature  <br>The method it is applied to must be static.|
|[BeforeScenario] or [Before]  <br>[AfterScenario] or [After]|possible|Automation logic that has to run before/after executing each scenario or scenario outline example|
|[BeforeScenarioBlock]  <br>[AfterScenarioBlock]|possible|Automation logic that has to run before/after executing each scenario block (e.g. between the "givens" and the "whens")|
|[BeforeStep]  <br>[AfterStep]|possible|Automation logic that has to run before/after executing each scenario step|

##### Parameter Injection

SpecFlow Contexts or Interfaces can be automatically injected in the Hook class constructor, as well as in the Hook methods themselves. For example, `ScenarioContext`, `FeatureContext`, `ITestRunnerManager`, and `ITestRunner`.

```cs
[Binding]
public class MyHooks
{
    [BeforeScenario]
    public void SetupTestUsers(ScenarioContext scenarioContext)
    {
        //scenarioContext...
    }
}
```

Depending on the type of the hook the parameters are resolved from a container with the corresponding lifecycle.

|Attribute|Container|
|---|---|
|[BeforeTestRun]  <br>[AfterTestRun]|TestThreadContainer|
|[BeforeFeature]  <br>[AfterFeature]|FeatureContainer|
|[BeforeScenario]  <br>[AfterScenario]  <br>[BeforeScenarioBlock]  <br>[AfterScenarioBlock]  <br>[BeforeStep]  <br>[AfterStep]|ScenarioContainer|

##### Options: Filtering and Order

```cs
[BeforeScenario] // Unpredictable order execution.
[BeforeScenario(Order = 0)] // Fixed order to be the first one executed.
```

```cs
[BeforeScenario("tag")] // Only for tests with this tag.
// OR
[Scope(Tag = "tag")]
[BeforeScenario]
```

#### Best Practices

- Organize Step Definitions into logical folders and classes in separate files, for clarity and preventing code duplication.
	- Keep steps separated by functionality.
	- If the same step is used in different scenarios, move it to a separate class and file, so it can easily be used and reused by multiple scenarios.
	- Use tagging for execution: ![[Pasted image 20231207131406.png]]


#### LivingDoc

##### Installation

To install, run the following command in a terminal (user dir):
```cli
dotnet tool install --global SpecFlow.Plus.LivingDoc.CLI
```

![[Pasted image 20231207083240.png]]

##### Usage

To use the tool in a project, `cd` to the `\bin\Debug\net8.0` directory within the project.

There, use the following command to generate the documentation:
```cli
livingdoc test-assembly .\BddAndSpecFlow.dll -t .\TestExecution.json
```

To open it:
```cli
.\LivingDoc.html
```




---

### Automated Testing and CI / CD

#### Overview

CI = Continuous Integration
CD = Continuous Deployment

Runs tests as part of the build.
This makes sure potentially problematic code, that makes a test fail, doesn't get deployed.

Common tools: Jenkins, Travis CI, CircleCI, GitHub Actions, and GitLab CI.

![[Pasted image 20231206221355.png]]
![[Pasted image 20231206221424.png]]

![[Pasted image 20231206221445.png]]

#### Regression Testing

![[Pasted image 20231206221614.png]]

![[Pasted image 20231206223133.png]]

![[Pasted image 20231206223317.png]]

#### SpecFlow + LivingDocs on Azure DevOps

[Video with demo setup](https://app.pluralsight.com/course-player?clipId=97290b99-0678-4592-ae84-064588f61419)



---
## E2E / UI Test Automation

![[Pasted image 20231204094137.png]]
![[Pasted image 20231204094200.png]]
![[Pasted image 20231204094212.png]]



### [Selenium](https://www.selenium.dev/)

#### Overview

Selenium automates the browser. Whatever the user can do, it can automate — a web crawler. Specifically, it is a free open-source software framework to automate end-to-end (E2E) tests.

E2E —End-to-End or UI tests — should be kept as a minimum and should not replace Unit and Integration tests.

Pros and Cons of Selenium:
- Popular, widespread, long history.
- Multiple language bindings.
- Only E2E (UI) tests.
- Runs outside the browser.
- Multi-user, multi-tab scenarios.
- All popular browsers supported.
- Huge community, great documentation.

Core Components:
- Selenium IDE — record & playback, for quick bug reproduction scripts.
- Selenium WebDriver — library to programmatically mimic user actions.
- Selenium Grid — create nodes to run tests in parallel. This can also be done by splitting up your Test Suite over multiple Test Groups and CI jobs.

![[Pasted image 20231204094848.png]]

![[Pasted image 20231204081237.png]]

Setup:
- Test Runner and an Assertion Library
- WebDriver Library (API)
- Browser Binary Driver

##### Alternatives

- Cypress
	- Newer.
	- JavaScript only.
	- Component and E2E tests.
	- Runs in the browser, so can mimic a user less well.
	- No multi-tabs.

- Playwright
	- New, maintained by Microsoft.
	- Multiple language bindings, similar to Cypress in JavaScript.
	- Component and E2E tests.
	- Runs outside the browser.
	- Multi-user and multi-tab scenarios.
	- Browsers in “Browser Contexts”.
	- Growing community, great documentation.

- Robot Framework (Selenium wrapper)
- applitools (uses visual AI)
- Katalon (uses Selenium, but not just a wrapper)

![[Pasted image 20231204081551.png]]

##### Cloud Browser Test Environment Providers

- LambdaTest
- Sauce Labs
- Browser Stack
- CrossBrowserTesting
- or use Docker for scalability.

##### Don't Use For

- Performance testing (use JMeter)
- UX - User Experience testing. Is the app easy and intuitive to use, and fulfill the user's needs?
- Test automation is not a replacement for all testing and the brain work. Working with Selenium is programming tests, not the testing itself.


#### [Selenium IDE](https://www.selenium.dev/selenium-ide/docs/en/introduction/getting-started)

Install through the browser of choice's plug-in/add-on installers.

Steps:
1. Create new project and input URL.
2. Add new test (+)
3. Record the actions in the browser (REC). Make sure they are repeatable for replay.
4. Add an assert command.
5. Run tests. You can set the speed and step through the actions like breakpoints.

Add a Test Suite to organize and group tests.

##### Assert vs. Verify

Verify check if the value is correct, marks the command and test accordingly, but does not stop the test. The test keeps going.
Assert is a hard stop if it fails. Later commands are not executed.

![[Pasted image 20231204134350.png]]

#### [Selenium WebDriver](https://www.selenium.dev/documentation/webdriver/)

Benefits of scripting tests:
- scalability
- maintainability
- range of possibilities
- version control

##### Selectors

Selectors — ways of selecting elements:
- By attribute: `By.TagName`, `By.ClassName`, `By.Id`, `By.Name`
- By link or text: `By.LinkTest`, `By.PartialLinkText`
- With XPath: `By.XPath`

In order of speed:
- `Id` (fastest and recommended)
- `ClassName`
- `Name`
- `CssSelector`
- `xPath` (slowest, but most versatile)

Avoid being too specific, but also not too generic.
Selecting elements must be simple, unambiguous, and future-proof.

![[Pasted image 20231204140228.png]]

![[Pasted image 20231204140415.png]]

![[Pasted image 20231204140510.png]]

##### Relative Locators

Not recommended.
![[Pasted image 20231204160322.png]]

##### Assertions

*Example:*
```cs
[Fact]
public void A_EmployeeLogin()
{
    // Chrome driver setup
    var driver = new ChromeDriver(_chromeOptions);
    // Set max wait untill element is found.
    driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(5); 

	// Go to Homepage
    driver.Navigate().GoToUrl("https://local.auth:5173/");

    // Lgin Employee
    driver.FindElement(By.XPath("//button[@id='login-button']")).Click();
    driver.FindElement(By.XPath("//input[@id='username']")).SendKeys(_employeeUsername);
    driver.FindElement(By.XPath("//input[@id='password']")).SendKeys(_employeePassword);
    driver.FindElement(By.XPath("(to long to show, left out for example)")).Click();

    // Assert that the Test Employee is logged in.
    var activeUserId = driver.FindElement(By.XPath("//li[@id='activeUserId']")).Text;
    Assert.Equal(_employeeId, activeUserId);

    driver.Quit();
}
```

Assert current URL:
```cs
Assert.Contains("https://local.auth/", driver.Url);
```

Assert that previously hidden element is visible:
```cs
Assert.True(driver.FindElement(By.Id("validation-error")).Displayed);
```

##### Navigate

```cs
driver.Navigate().GoToUrl("https://something.com");
				 .Refesh();
				 .Back();
				 .Forward();
```

##### Actions

###### Mouse Actions

Double-click an element:
```cs
var button = driver.FindElement(By.Id("btn"));
var actions = new Actions(driver);
actions.DoubleClick(button).Perform();
```

Move cursor to certain location and click:
```cs
actions.MoveByOffset(button.Location.X + 5, button.Location.Y + 5).Click().Perform();
```

Right click / Open Context Menu:
```cs
actions.ContextClick(); // Where the cursor is atm.
actions.ContextClick(button); // On specific element.
```

###### Keyboard Actions

Typing text:
```cs
var textArea = driver.FindElement(By.Id("text-area"));
textArea.Clear();
textArea.SendKeys("Text to type.");
```

Pressing Keys — Clearing text when `.Clear()` does not work:
```cs
// By selecting all text and deleting it.
textArea.SendKeys(Keys.Control + "A"); // Select all text.
textArea.SendKeys(Keys.Delete); // Delete selection.

// Cross platform solution with Actions class:
var actions = new Actions(driver);
actions.Click(textArea)
	   .SendKeys(Keys.End)
	   .KeyDown(Keys.Shift)
	   .SendKeys(Keys.Home)
	   .SendKeys(Keys.Backspace)
	   .Perform();
```

File input / upload:
```cs
var fileInput = driver.FindElement(By.Id("upload"));
fileInput.SendKeys(Path.GetFullPath(Path.Join("DirName", "file.pdf")));

// To clear the upload again.
fileInput.Clear(); 
Assert.Empty(fileInput.GetAttribute("value"));
```

1. In your project, make sure the file is there, right-click to go to Properties:
![[Pasted image 20231205100352.png]]

2. Change *Copy to Output Directory* to *Copy if newer*:
![[Pasted image 20231205100119.png]]

###### [Select Dropdown Option](https://www.selenium.dev/documentation/webdriver/support_features/select_lists/)

Requires `Selenium.Support` NuGet package dependency.

To select and option in a select element:
![[Pasted image 20231205101603.png]]

```cs
var dropdown = driver.FindElement(By.Id("select-element"));
var select = new SelectElement(dropdown); // Selenium.Support package

// Get a list of all options in the `<select>` element:
IList<IWebElement> optionList = select.Options;

// Select an option:
select.SelectByText("Four");
select.SelectByValue("two");
select.SelectByIndex(3);

// De-select an option:
select.DeselectByValue("eggs");

// Assert selection:
Assert.Equal("expected", select.SelectedOption.GetAttribute("value"));

// Get all selected options, single select has one, multiple select has zero or more:
IList<IWebElement> selectedOptionList = select.AllSelectedOptions;

// Asserts values match the right text:
select.SelectByValue("true");
Assert.Equal("Yes", select.SelectedOption.Text);

// Assert disabled option exception throw:
Assert.ThrowsException<InvalidOperationException>(() => select.SelectByValue("disabled"));
```

###### Checkbox Selection

Check state before clicking a checkbox:
```cs
var checkbox = driver.FindElement(By.Id("checkbox"));
if(!checkbox.Selected) checkbox.Click();

Assert.True(checkbox.Selected);
```

##### Reading Element Attributes and States

![[Pasted image 20231205104356.png]]

##### Using JavaScript Commands

Sometimes, to perform an action like a click, there first needs to be scrolled down a page. This can be done with JavaScript:

```cs
protected void ScrollToElement(IWebElement element)
{
    ((IJavaScriptExecutor)Driver).ExecuteScript(
	    "arguments[0].scrollIntoView(true)", element); 
	    // JavaScript code as a string
    
    Thread.Sleep(500);
}
```

##### Handling Pop-ups

###### Alert

```cs
var alertWindow = driver.SwitchTo().Alert(); 
alertWindow.Accept(); // Alert shows only information.
```

###### Confirmation

```cs
// In PageObject
private List<IWebElement> OrderTableItems => driver
	.FindElements(...).ToList();

public void ClickOnRemoveButton(int index)
{
	OrderTableItems[index].FindElement(By.TagName("button")).Click();
}

public int GetOrderCount() => return OrderTableItems.Count;
```

```cs
// In test
orderPage.ClickOnRemoveButton(0);
var confirmationWindow = driver.SwitchTo().Alert();
confirmationWindow.Dismiss();
```

##### Windows and Tabs

```cs
// Get current Window or Tab:
var windowOne = driver.CurrentWindowHandle;

// Open new Window:
driver.SwitchTo().NewWindow(WindowType.Window);
var windowTwo = driver.CurrentWindowHandle;

// Open new Tab:
driver.SwitchTo().NewWindow(WindowType.Tab);
var tabTwo = driver.CurrentWindowHandle;

// Switch to a specific Window or Tab:
driver.SwitchTo().Window(windowOne);
```

##### Waits

Sets the time to wait for an element to be found. Making the Driver look for it continuously, or retry at a set polling interval, during the set timespan. If found, the test will continue. If it is not found within the set timespan, the test will fail.

###### Implicit Wait

Set on a driver level, so it is done on every driver method.
```cs
Driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(5);
```

###### Explicit Wait

Has to be created and invoked with a condition.
```cs
var wait = new WebDriverWait(Driver, TimeSpan.FromSeconds(5));
wait.Until(e => e.FindElement(By.Id("element-id")));
```

###### Fluent Wait

Similar to the Explicit Wait, but adds a polling interval that makes the driver wait between retries:
```cs
var wait = new WebDriverWait(Driver, TimeSpan.FromSeconds(5))
{
	PollingInterval = TimeSpan.FromSeconds(1)
};
wait.Until(e => e.FindElement(By.Id("element-id")));
```

###### Wait Helpers

Not officially supported any more by Selenium for .NET, but available through an unofficial NuGet package `DotNetSeleniumExtras.WaitHelpers`, though not maintained anymore either. Can be used as a base for own implementation.

![[Pasted image 20231205220646.png]]

##### Chrome DevTools

Setup:
```cs
public class ChromeDevToolsProtocolTests : TestsBase
{
    private readonly OpenQA.Selenium.DevTools.DevToolsSession Session;

    public ChromeDevToolsProtocolTests()
    {
        var devTools = Driver as OpenQA.Selenium.DevTools.IDevTools;
        Session = devTools.GetDevToolsSession();
    }

    // Tests
}
```

###### Emulating Device Mode

```cs
[Fact]
    public async Task EmulateDeviceModeTest()
    {
        var deviceSettings = new OpenQA.Selenium.DevTools.V119.Emulation.SetDeviceMetricsOverrideCommandSettings()
        {
            Width = 400,
            Height = 600,
            DeviceScaleFactor = 2,
            Mobile = true,
        };

        await Session.GetVersionSpecificDomains<OpenQA.Selenium.DevTools.V119.DevToolsSessionDomains>()
            .Emulation
            .SetDeviceMetricsOverride(deviceSettings);

        NavigateToPage("Home");

        Thread.Sleep(5000);
    }
```

###### Emulating Network Conditions

You can set the network speed, though Selenium is not recommended for performance tests.

```cs
[Fact]
public async Task EmulateNetworkConditionsTest()
{
    var networkConditions = new OpenQA.Selenium.DevTools.V119.Network.EmulateNetworkConditionsCommandSettings()
    {
        DownloadThroughput = 1000,

    };

    await Session.GetVersionSpecificDomains<OpenQA.Selenium.DevTools.V119.DevToolsSessionDomains>()
        .Network
        .EmulateNetworkConditions(networkConditions);

    Driver.Navigate().GoToUrl("https://selenium.dev");
}
```

###### Emulating Geolocation

```cs
[Fact]
public async Task EmulateGeolocationTest()
{
    var geolocation = new OpenQA.Selenium.DevTools.V119.Emulation.SetGeolocationOverrideCommandSettings()
    {
        Latitude = 40,
        Longitude = 0,
        Accuracy = 1,
    };

    await Session.GetVersionSpecificDomains<OpenQA.Selenium.DevTools.V119.DevToolsSessionDomains>()
        .Emulation
        .SetGeolocationOverride(geolocation);

    Driver.Navigate().GoToUrl("https://maps.google.com");
    Driver.FindElement(By.CssSelector("#mylocation #sVuEFc")).Click();

    Thread.Sleep(5000);
}
```

###### Intercepting HTTP Requests

[Video](https://app.pluralsight.com/course-player?clipId=d5d4d70d-f800-4bc0-97ef-827c9838ec04)

```cs
[Fact]
public async Task InterceptNetworkRequestsTest()
{
    var fetch = Session.GetVersionSpecificDomains<OpenQA.Selenium.DevTools.V119.DevToolsSessionDomains>()
        .Fetch;

    var enableCommandSettings = new OpenQA.Selenium.DevTools.V119.Fetch.EnableCommandSettings();

    var requestPattern = new OpenQA.Selenium.DevTools.V119.Fetch.RequestPattern
    {
        RequestStage = OpenQA.Selenium.DevTools.V119.Fetch.RequestStage.Request,
        ResourceType = OpenQA.Selenium.DevTools.V119.Network.ResourceType.XHR,
        UrlPattern = "*/workshops.json"
    };

    enableCommandSettings.Patterns = new OpenQA.Selenium.DevTools.V119.Fetch.RequestPattern[] { requestPattern };   

    await fetch.Enable(enableCommandSettings);

    async void requestIntercepted(object sender, OpenQA.Selenium.DevTools.V119.Fetch.RequestPausedEventArgs e)
    {
        await fetch.FulfillRequest(new OpenQA.Selenium.DevTools.V119.Fetch.FulfillRequestCommandSettings()
        {
            RequestId = e.RequestId,
            Body = Convert.ToBase64String(Encoding.UTF8.GetBytes(
                """
                [
                    { ... }
                ]
                """)),
            ResponseCode = 200
        });
    }

    fetch.RequestPaused += requestIntercepted;

    Driver.Navigate().GoToUrl("");

    Thread.Sleep(10000);
}
```


#### [Selenium Grid](https://www.selenium.dev/documentation/grid/)

[Videos](https://app.pluralsight.com/course-player?clipId=486bc230-c5e7-4b48-ba38-9c018256d96d)

Three modes:
- Distributed — each component is run and configured separately. Scales best.
- Hub & Node — the Hub is composed of five orchestration components and acts as a single entry point, distributing task across multiple nodes. A Node acts as an environment where the tests are executed.
- Standalone — used for simple continuous integration servers. Does not scale.

![[Pasted image 20231205230018.png]]

![[Pasted image 20231205230606.png]]

[Grid Setup Video](https://app.pluralsight.com/course-player?clipId=fbc6b9eb-e94d-4fec-915c-0ea1522d6366)

### Page Object Model (POM)

[What is Page Object Model — Selenium 4 Fundamentals with C#](https://app.pluralsight.com/course-player?clipId=0248a528-a452-4c44-aaa8-a0b865ae0e05)

Page Object Model is a design pattern used in test automation:
- to reduce code duplication,
- to achieve better code maintainability,
- easier scalability of testing projects.

![[Pasted image 20231205135616.png]]

Every web page or page fragment of the SUT gets its own Page Object Class. Tests (Test Classes) then use the methods and properties of the Page Objects to interact with the UI of the page the object represents.

The Page Object Model hides the UI implementation details from the tests. Separating the test logic from the page details.

When the UI implementation changes, only the Object Model needs to be updates. The tests themselves don't need to change.

Abstraction in POM can range from only hiding selectors and web elements, to also hiding actions and assertions, so the tests don't even need to know Selenium is being used. The latter makes the tests more readable.
The level of abstraction is a balance between readability, maintainability, and efficiency. Where consistency in implementation is very important.

#### Tests Base Class and Configuration File

##### Configuration File

Steps:
1. Install the `Microsoft.Extensions.Configuration.Json` NuGet package. ![[Pasted image 20231205150604.png]]

2. Create a Configuration directory.
3. Create a settings JSON file:
```json
{
  "browser": "chrome"
}
```

4. Create a `TestsConfigurationProvider` class:
```cs
using Microsoft.Extensions.Configuration;

namespace TimesheetApp.SeleniumTests.Configuration;

internal class TestsConfigurationProvider
{
    private static ConfigurationManager? config;

    public static ConfigurationManager Config
    {
        get
        {
            if (config == null)
            {
                config = new ConfigurationManager();
                config.AddJsonFile(
	                "testsettings.local.json", false, false);
            }
            return config;
        }
    }
}

```

##### Tests Base Class

```cs
public class TestsBase : IDisposable
{
    private IWebDriver Driver;

    public TestsBase() // Setup
    {
        Driver = CreateDriver(
	        TestsConfigurationProvider.Config["browser"]);

        Driver.Manage().Timeouts().ImplicitWait
	        = TimeSpan.FromSeconds(5);
    }

    public void Dispose()
    {
        Driver.Quit();
    }

    public IWebDriver GetDriver() => Driver;

    private IWebDriver CreateDriver(string browserName)
    {
        switch (browserName.ToLowerInvariant())
        {
            case "chrome":
                var chromeOptions = new ChromeOptions();

                chromeOptions.AcceptInsecureCertificates = true;
                //chromeOptions.AddArgument("--headless");
                chromeOptions.AddArgument("--window-size=1000,800");

                return new ChromeDriver(chromeOptions);

            case "firefox":
                var firefoxOptions = new FirefoxOptions();

                firefoxOptions.AcceptInsecureCertificates = true;
                //firefoxOptions.AddArgument("--headless");
                firefoxOptions.AddArgument("--window-size=1000,800");

                return new FirefoxDriver(firefoxOptions);

            case "edge":
                var edgeOptions = new EdgeOptions();

                edgeOptions.AcceptInsecureCertificates = true;
                //edgeOptions.AddArgument("--headless");
                edgeOptions.AddArgument("--window-size=1000,800");

                return new EdgeDriver(edgeOptions);

            default:
                throw new ArgumentException($"The provided browser name, {browserName}, is not a supported browser.");
        }
    }

    public void NavigateToPage(string pageName)
    {
        Driver.Navigate().GoToUrl(
	        $"{TestsConfigurationProvider.Config["baseURL"]}{pageName}");
    }
```


### xUnit

#### [Shared Context](https://xunit.net/docs/shared-context)

```c#
public class StackTests : IDisposable // Interface for context clean-up
{
    Stack<int> stack;

    public StackTests() // Constructor
    {
        stack = new Stack<int>();
    }

    public void Dispose() // xUnit Dispose clean-up function
    {
        stack.Dispose();
    }
    
	// The actual tests
}
```

#### [Trait Attribute (Tagging)](https://www.brendanconnolly.net/organizing-tests-with-xunit-traits/)

*Similar to Categories in NUnit and MSTest.*

```cs
[Trait("Category","MyCategoryName")]
```

*Example:*
```cs
[Fact]
[Trait("Category","UI")]
public void Test3(){
    ...}
```



### Xpath

Xpath stands for XML Path Language, is part of the XSLT standard, and is used to navigate through elements and attributes in an XML document.
It uses path like syntax to identify and navigate nodes in an XML document.

![[Pasted image 20231129213603.png]]

![[Pasted image 20231205201115.png]]

#### [SelectorsHub](https://selectorshub.com/selectorshub/)

Select the element you want with Inspect Page and it gives you selection options.

![[Pasted image 20231204154535.png]]

#### Path Expressions

Xpath uses path expressions, similar to the path in a file system, to select nodes or node-sets in an XML document.

Absolute location path starts with `/`, e.g., `/books/book`
Relative location path does not, e.g., `books/book`

An XPath expression returns either a node-set, a string, a Boolean, or a number.

![[Pasted image 20231129213833.png]]

#### Nodes

XML documents are treated as trees of nodes. The topmost element is the root element.

7 types of nodes:
- element
- attribute
- text
- namespace
- processing-instruction
- comment
- root

*Example:*
```xml
<?xml version="1.0" encoding="UTF-8"?>  
  
<bookstore>  // root element node
  <book>  // element node
    <title lang="en">Harry Potter</title> 
	    // lang="en" is an attribute node
	    // "en" is an atomic value
    <author>J K. Rowling</author>  // element node
	    // J K. Rowling is an atomic value
    <year>2005</year>  
    <price>29.99</price>  
  </book>  
</bookstore>
```

3 types of relationships between nodes:
- Parent
- Child: node in another node.
- Sibling: child nodes with the same parent.
- Ancestor: all parents, and parents of parents.
- Descendants: all children, and children of children.

#### Selecting Nodes

A node is selected by following a path or steps.

Absolute location path starts with `/`: `/step/step`
Relative location path does not: `step/step`

| Expression | Description                                                                                           |
| ---------- | ----------------------------------------------------------------------------------------------------- |
| _nodename_ | Selects all nodes with the name "_nodename_"                                                          |
| /          | Selects from the root node (absolute path)                                                                           |
| //         | Selects nodes in the document from the current node that match the selection no matter where they are |
| .          | Selects the current node                                                                              |
| ..         | Selects the parent of the current node                                                                |
| @          | Selects attributes                                                                                    |

##### Wildcards

|Wildcard|Description|
|---|---|
|*|Matches any element node|
|@*|Matches any attribute node|
|node()|Matches any node of any kind|

##### Predicates

Predicates are used to find a specific node or a node that contains a specific value, and are always embedded in square brackets `[predicate]`.

|Path Expression|Result|
|---|---|
|/bookstore/book[1]|Selects the first book element that is the child of the bookstore element.<br><br>**Note:** In IE 5,6,7,8,9 first node is[0], but according to W3C, it is [1]. To solve this problem in IE, set the SelectionLanguage to XPath:<br><br>_In JavaScript: xml_.setProperty("SelectionLanguage","XPath");|
|/bookstore/book[last()]|Selects the last book element that is the child of the bookstore element|
|/bookstore/book[last()-1]|Selects the last but one book element that is the child of the bookstore element|
|/bookstore/book[position()<3]|Selects the first two book elements that are children of the bookstore element|
|//title[@lang]|Selects all the title elements that have an attribute named lang|
|//title[@lang='en']|Selects all the title elements that have a "lang" attribute with a value of "en"|
|/bookstore/book[price>35.00]|Selects all the book elements of the bookstore element that have a price element with a value greater than 35.00|
|/bookstore/book[price>35.00]/title|Selects all the title elements of the book elements of the bookstore element that have a price element with a value greater than 35.00|

##### Combining expressions

|Path Expression|Result|
|---|---|
|//book/title \| //book/price|Selects all the title AND price elements of all book elements|
|//title \| //price|Selects all the title AND price elements in the document|
|/bookstore/book/title \| //price|Selects all the title elements of the book element of the bookstore element AND all the price elements in the document|

##### Axes

An axis represents a relationship to the context (current) node, and is used to locate nodes relative to that node on the tree.

It defines the tree-relationship between the selected nodes and the current node.

|AxisName|Result|
|---|---|
|ancestor|Selects all ancestors (parent, grandparent, etc.) of the current node|
|ancestor-or-self|Selects all ancestors (parent, grandparent, etc.) of the current node and the current node itself|
|attribute|Selects all attributes of the current node|
|child|Selects all children of the current node|
|descendant|Selects all descendants (children, grandchildren, etc.) of the current node|
|descendant-or-self|Selects all descendants (children, grandchildren, etc.) of the current node and the current node itself|
|following|Selects everything in the document after the closing tag of the current node|
|following-sibling|Selects all siblings after the current node|
|namespace|Selects all namespace nodes of the current node|
|parent|Selects the parent of the current node|
|preceding|Selects all nodes that appear before the current node in the document, except ancestors, attribute nodes and namespace nodes|
|preceding-sibling|Selects all siblings before the current node|
|self|Selects the current node|

##### Step

Consists of:
- Axis — defines the tree-relationship between the selected nodes and the current node.
- Node-test — identifies a node within an axis.
- Predicate(s) — zero or more, to further refine the selected node-set.

Syntax: `axisname::nodetest[predicate]`

|Example|Result|
|---|---|
|child::book|Selects all book nodes that are children of the current node|
|attribute::lang|Selects the lang attribute of the current node|
|child::*|Selects all element children of the current node|
|attribute::*|Selects all attributes of the current node|
|child::text()|Selects all text node children of the current node|
|child::node()|Selects all children of the current node|
|descendant::book|Selects all book descendants of the current node|
|ancestor::book|Selects all book ancestors of the current node|
|ancestor-or-self::book|Selects all book ancestors of the current node - and the current as well if it is a book node|
|child::*/child::price|Selects all price grandchildren of the current node|

##### Operators

|Operator|Description|Example|
|---|---|---|
|\||Computes two node-sets|//book \| //cd|
|+|Addition|6 + 4|
|-|Subtraction|6 - 4|
|* |Multiplication|6 * 4|
|div|Division|8 div 4|
|=|Equal|price=9.80|
|!=|Not equal|price!=9.80|
|<|Less than|price<9.80|
|<=|Less than or equal to|price<=9.80|
|>|Greater than|price>9.80|
|>=|Greater than or equal to|price>=9.80|
|or|or|price=9.80 or price=9.70|
|and|and|price>9.00 and price<9.90|
|mod|Modulus (division remainder)|5 mod 2|

##### Practical Steps

1. Loading the XML document:
```js
var xmlhttp = new XMLHttpRequest();
```

2. Chrome, Firefox, Edge, Opera, and Safari use the evaluate() method to select nodes:
```js
xmlDoc.evaluate(_xpath_, xmlDoc, null, XPathResult.ANY_TYPE,null);
```

   Internet Explorer uses the selectNodes() method to select node:
```js
xmlDoc.selectNodes(_xpath_);
```

Example:
```html
<!DOCTYPE html><html><body><p id="demo"></p><script>

var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        showResult(xhttp.responseXML);
    }
};
xhttp.open("GET", "books.xml", true);
xhttp.send(); 

function showResult(xml) {
    var txt = "";
    path = "/bookstore/book[price>35]/price";
    
    if (xml.evaluate) {
        var nodes = xml.evaluate(
	        path, xml, null, XPathResult.ANY_TYPE, null);
        
        var result = nodes.iterateNext();
        
        while (result) {
            txt += result.childNodes[0].nodeValue + "<br>";
            result = nodes.iterateNext();
        } 
    } 
    
    // Code For Internet Explorer
    else if (
	    window.ActiveXObject || 
	    xhttp.responseType == "msxml-document") {
	        
	        xml.setProperty("SelectionLanguage", "XPath");
	        nodes = xml.selectNodes(path);
	        
	        for (i = 0; i < nodes.length; i++) {
	            txt += nodes[i].childNodes[0].nodeValue + "<br>";
        }
    }
    
    document.getElementById("demo").innerHTML = txt;
}
</script></body></html>
```

---

## Manual Testing

Manual Testing prevails when cognitive and behavioral abilities are required to test the software.

It mainly works well for testing:
- Functionalities
- User Interface (UI)
- User Experience (UX)
- Website & App Behavior
- Features
- User Acceptance

![[Pasted image 20231213201810.png]]

Manual techniques are further divided into:
- Functional testing - giving a Yes or No answer.
	- Positive flow/path
	- Negative flow/path
- Non-functional testing - answering with a number.

- Reproducing a defect is very important, so the developper can try it as well, and to be able to pinpoint its cause.

### Manual Testing VS Automation Testing

![[Pasted image 20231213201702.png]]

### Exploratory Testing

[YouTube: Explore It? Explore It! - Elisabeth Hendrickson](https://www.youtube.com/watch?v=9FKY1Is0lgs)
[Book: Explore It! - Elisabeth Hendrickson](https://pragprog.com/titles/ehxta/explore-it/)

![[Pasted image 20231218081729.png]]

#### Methodical exploration in Sessions

![[Pasted image 20231218082208.png]]

![[Pasted image 20231218082233.png]]
![[Pasted image 20231218082414.png]]

![[Pasted image 20231218082505.png]]
![[Pasted image 20231218082609.png]]
![[Pasted image 20231218082745.png]]

#### Heuristics

Heuristics are test design techniques, a pre-planned problem-solving technique derived from past experiences, to explore for risk.

- Play with boundaries and constraints. ![[Pasted image 20231218083420.png]]
  
- Experimenting with sequences. ![[Pasted image 20231218083528.png]]
  
-  Exploit States and Events. While ... ![[Pasted image 20231218083626.png]]
  
- Analyze Entities & Relationships. ![[Pasted image 20231218092440.png]]
  
#### Oracles

Oracles is a way to recognize what might be a problem.

> An oracle is a special kind of heuristic which helps you identify and describe a problem. Yet no oracle is definitive, and they should only ever be thought of as providing you with a pointer to a possible problem.

> For example, I often use a consistency heuristic where I expect each element of a product to be consistent with comparable elements of the same product – one such approach from Michael Bolton’s [FEW HICCUPPS heuristic](https://www.developsense.com/blog/2012/07/few-hiccupps/).

>Using Trello recently to manage a couple of side projects, I noticed that there is an inconsistency in the way fields on cards can be edited. Clicking in the Description or Tasks fields puts the field straight into Edit mode, whereas to edit a Comment requires an explicit click on the “Edit” action. This is a good example of the Trello product being inconsistent with itself in terms of editing fields on a card – and note that the oracle in this case is the product itself.

##### [FEW HICCUPS](https://developsense.com/blog/2012/07/few-hiccupps)

Expectations about a product revolve around _desirable consistencies between related things_.

- **History.** We expect the present version of the system to be consistent with past versions of it.
- **Image.** We expect the system to be consistent with an image that the organization wants to project, with its brand, or with its reputation.
- **Comparable Products.** We expect the system to be consistent with systems that are in some way comparable. This includes other products in the same product line; competitive products, services, or systems; or products that are not in the same category but which process the same data; or alternative processes or algorithms.
- **Claims.** We expect the system to be consistent with things important people say about it, whether in writing (references specifications, design documents, manuals, whiteboard sketches…) or in conversation (meetings, public announcements, lunchroom conversations…).
- **Users’ Desires.** We believe that the system should be consistent with ideas about what reasonable users might want. _(Update, 2014-12-05: We used to call this “user expectations”, but those expectations are typically based on the other oracles listed here, or on quality criteria that are rooted in_ desires_; so, “user desires” it is. More on that [here](http://www.developsense.com/blog/2014/01/not-so-great-expectations/ "Not-So-Great Expectations").)_
- **Product.** We expect each element of the system (or product) to be consistent with comparable elements in the same system.
- **Purpose.** We expect the system to be consistent with the explicit and implicit uses to which people might put it.
- **Statutes *and Standards*.** We expect a system to be consistent with laws or regulations that are relevant to the product or its use.

Extended:
- **Explainability.** Any kind of confusion in the product is an issue and bound to create bugs.
- **World.** We expect the product to be consistent with things that we know about, or can observe, in the world.
- **Familiarity.** We expect the SUT to be inconsistent with patterns of familiar problems. You can start by looking for bugs you found in other products, but they may not be important for the product you are testing now.


#### Kolb Learing Cycle

![[Pasted image 20231218093118.png]]

#### Other Testing Methods

##### Product Value and Risks

Steps:
1. Understand the value of the product to test.
2. Come up with possible risks — what can take away the value, or make it fail to deliver its value.
3. Create questions from the risks.
4. Perform a test session to answer your questions.
5. Share your findings.


##### Strategic Testing Model

[A new model for test strategies… (An update to the Heuristic Test Strategy Model) — Dan Ashby](https://danashby.co.uk/2017/12/13/a-new-model-for-test-strategies/)

![[Pasted image 20231218162647.png]]

Simplified:
![[Pasted image 20231218161131.png]]


### Tips & Tricks

- Combine test cases.
- Think of Error states? Transition states? Empty states? Characters limits? File size limits?
- [Quality Tree Software - Test Heuristics Cheat Sheet - Data Type Attacks & Web Tests](https://goritskov.com/media/files/testheuristicscheatsheetv1.pdf)
- [Michael Hunter's You Are Not Done Yet checklist](https://www.thebraidytester.com/downloads/YouAreNotDoneYet.pdf)
- [Ministry of Testing](https://www.ministryoftesting.com/search?q=test+heuristics+cheat+sheet)
- [Big List of Naughty Strings](https://github.com/minimaxir/big-list-of-naughty-strings)


### Tools

- [Testing Tools by Testing Category](https://testomat.io/blog/top-15-manual-testing-tools-to-know/)
- [Perlclip - String generator to Clipboard](https://www.satisfice.com/download/perlclip)
- [Bug Magnet - Exploratory testing assistant for Chrome](https://chromewebstore.google.com/detail/bug-magnet/efhedldbjahpgjcneebmbolkalbhckfi?hl=en)
- [Fake (Form) Filler](https://chromewebstore.google.com/detail/fake-filler/bnjjngeaknajbdcgpfkgnonkmififhfo?hl=en)
- [TestBuddy](https://www.youtube.com/watch?v=Wu4xTnoreLY)


### Ad-hoc / Monkey / Fuzz / Gremlin Testing

[Medium: Monkey Testing - let's break things](https://medium.com/@qa.gary.parker/monkey-testing-lets-break-things-b3e8efb63fda)

Bombarding a web application with JavaScript Gremlins doing all sorts of random interactions to test the robustness / resilience of the app.

[GitHub: gremlins.js](https://github.com/marmelab/gremlins.js)
[Bookmarklet of gremlins.js](https://marmelab.com/gremlins.js/)


### API Testing with Postman

[Learning Postman: Test Examples](https://learning.postman.com/docs/writing-scripts/script-references/test-examples/)

