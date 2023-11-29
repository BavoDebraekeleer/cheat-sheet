# Quality Assurance

### Frontend

#### Selenium

#### Xpath

[Xpath _cheatsheet_](https://devhints.io/xpath)
[W3schoold Xpath Tutorial](https://www.w3schools.com/xml/xpath_intro.asp)
[Udemy: XPath Tutorial from basic to advance level. The complete XPath course for Selenium — Sanjay Kumar](https://www.udemy.com/course/xpath-tutorial-from-basic-to-advance-level/?signupsuccess=1)

Xpath stands for XML Path Language, is part of the XSLT standard, and is used to navigate through elements and attributes in an XML document.
It uses path like syntax to identify and navigate nodes in an XML document.

![[Pasted image 20231129213603.png]]

##### Path Expressions

Xpath uses path expressions, similar to the path in a file system, to select nodes or node-sets in an XML document.

Absolute location path starts with `/`, e.g., `/books/book`
Relative location path does not, e.g., `books/book`

An XPath expression returns either a node-set, a string, a Boolean, or a number.

![[Pasted image 20231129213833.png]]

##### Nodes

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

##### Selecting Nodes

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

###### Wildcards

|Wildcard|Description|
|---|---|
|*|Matches any element node|
|@*|Matches any attribute node|
|node()|Matches any node of any kind|

###### Predicates

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

###### Combining expressions

|Path Expression|Result|
|---|---|
|//book/title \| //book/price|Selects all the title AND price elements of all book elements|
|//title \| //price|Selects all the title AND price elements in the document|
|/bookstore/book/title \| //price|Selects all the title elements of the book element of the bookstore element AND all the price elements in the document|

###### Axes

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

###### Step

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

###### Operators

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

###### Practical Steps

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

### Backend

#### SpecFlow and Gherkin



Gerkin
Selenium
SpecFlow
Expath

given
when
then