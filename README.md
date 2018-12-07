# :rocket: xunit-to-html


[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

**xunit-to-html** converts xUnit XML reports into beautiful looking HTML reports using XSLT.

![usage](/usage.gif)

# Supported Frameworks
xunit-to-html can be used to generate beautiful looking reports from any xUnit supported test framework, including the following ones:
* JUnit (supported schema are Ant junit and Maven Surefire)
* AUnit 
* MSTest (imported from MSTest Plugin)
* NUnit (imported from NUnit Plugin)
* UnitTest++ 
* Boost Test Library
* PHPUnit
* Free Pascal Unit
* CppUnit
* MbUnit
* Googletest
* EmbUnit
* gtester/glib
* QTestLib
* nosetests

# Prerequisites
1. Environment with Java 8+ installed
2. The open source [Saxon](http://saxon.sourceforge.net/) Home Edition jar which has been included in this repository.

# Installing and Getting Started

**xunit-to-html** can be easily be used as part of a build pipeline to produce beautiful looking test reports.

1. Clone this repository
2. Run your tests and generate an xUnit XML report using a test framework of your choice.
3. Assuming the input xUnit report name is `report.xml`, and we want to generate an html report `report.html`:
```bash
java -jar saxon9he.jar -o:report.html -s:report.xml -xsl:xunit_to_html.xsl
```
`report.html` will be generated in the working directory, you can now view or push the report to the cloud for further visibility.

# Authors

- [**Muntazir Fadhel**](https://zir0-93.github.io/) - *Initial work and maintainer* 
