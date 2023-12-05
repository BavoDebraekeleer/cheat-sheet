# Quality Assurance

## Introduction

QA — Quality Assurance — is a process-oriented, preventive approach that focuses on the implementation and improvement of processes. It works on the basis that if a good process is followed correctly, then it will generate a good product. QA applies to both the development and testing processes, and is the responsibility of everyone on a project.

While people often use the terms “testing” and “quality assurance” (QA) interchangeably, testing and QA are not the same. Testing is a form of quality control (QC).

QC is a product-oriented, corrective approach that focuses on those activities supporting the achievement of appropriate levels of quality. Testing is a major form of quality control, while others include formal methods (model checking and proof of correctness), simulation and prototyping.

Test results are used by QA and QC. In QC, they are used for fixing defects, while in QA they provide feedback on how well the development and test processes are performing.

---

## Frontend

![[Pasted image 20231204094137.png]]
![[Pasted image 20231204094200.png]]
![[Pasted image 20231204094212.png]]



### E2E/UI Test Automation with [Selenium](https://www.selenium.dev/)

[Pluralsight: Selenium 4: The Big Picture — Andrejs Doronins](https://app.pluralsight.com/library/courses/selenium-4-big-picture/table-of-contents)
[Pluralsight: Selenium 4 Fundamentals with C# — Marko Vajs](https://app.pluralsight.com/library/courses/selenium-4-fundamentals-c-sharp/table-of-contents)
[YouTube: SeleniumConf Chicago 2023 playlist](https://www.youtube.com/playlist?list=PLRdSclUtJDYXDEsWI0vwBmJxW17NgsaAk)

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

[Xpath _cheat sheet_](https://devhints.io/xpath)
[SelectorsHub Xpath plugin](https://selectorshub.com/selectorshub/)
[W3schoold Xpath Tutorial](https://www.w3schools.com/xml/xpath_intro.asp)
[Udemy: XPath Tutorial from basic to advance level. The complete XPath course for Selenium — Sanjay Kumar](https://www.udemy.com/course/xpath-tutorial-from-basic-to-advance-level/?signupsuccess=1)

Xpath stands for XML Path Language, is part of the XSLT standard, and is used to navigate through elements and attributes in an XML document.
It uses path like syntax to identify and navigate nodes in an XML document.

![[Pasted image 20231129213603.png]]

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

## Backend

### Behavior-driven Development (BDD) with SpecFlow

![[Pasted image 20231204150426.png]]


### Gherkin

![[Pasted image 20231204150412.png]]


given
when
then

---
