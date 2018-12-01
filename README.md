# :rocket: xunit-to-html
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

*Converts xUnit XML reports into beautiful looking HTML reports using XSLT.*

![usage](/usage.gif)


# Prerequisites
1. Environment with Java 8+ installed
2. [Saxon](http://saxon.sourceforge.net/) Home Edition Jar which has been included in this repository.

# Installing and Getting Started

*xunit-to-html can be easily be used as part of a build pipeline to produce beautiful looking test reports*.

1. Simply clone the current repository
2. Assuming the input xUnit/jUnit report name is `report.xml` and we want to generate an html report `report.html`, execute the following:
```bash
java -jar saxon9he.jar -o:report.html -s:report.xml -xsl:xunit_to_html.xsl
```
3. `report.html` will be generated in the working directory, now you are free to view or push to the cloud for further visibility.

# Authors

- [**Muntazir Fadhel**](https://zir0-93.github.io/) - *Initial work and maintainer* 
