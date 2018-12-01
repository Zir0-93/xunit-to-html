<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <xsl:variable name="total_tests" select="sum(//testsuite/@tests[number(.) = number(.)])">
        </xsl:variable>
        <xsl:variable name="total_errors" select="sum(//testsuite/@errors[number(.) = number(.)])">
        </xsl:variable>
        <xsl:variable name="total_failures" select="sum(//testsuite/@failures[number(.) = number(.)])">
        </xsl:variable>
        <xsl:variable name="total_successful" select="$total_tests - ($total_errors + $total_failures)">
        </xsl:variable>
        <xsl:variable name="total_time" select="sum(//testsuite/testcase/@time[number(.) = number(.)])">
        </xsl:variable>
        <xsl:variable name="total_m" select="floor($total_time div 60)">
        </xsl:variable>
        <xsl:variable name="total_s" select="$total_time mod 60">
        </xsl:variable>
        <html>
            <head>
                <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet"/>
                <style>
                    .errorMessage {
                		font-size: 16px;
    					font-family: Lato;
    					font-weight: 300;
    					color: black;
                        display: inline;
                        border-radius: 5px;
                        padding: 1px;
                	}
                	.errorColor {
                		background-color: #f7e1d4;
                	}
                	.failureColor {
                		background-color: #f7d4d4;
                	}
                </style>
                <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
                <link href="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.3/dist/semantic.min.css" rel="stylesheet"/>
                <script crossorigin="anonymous" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" src="https://code.jquery.com/jquery-3.1.1.min.js">
                </script>
                <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.3.3/dist/semantic.min.js">
                </script>
                <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js">
                </script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.address/1.6/jquery.address.min.js">
                </script>
            </head>
            <body style="color:rgba(47, 53, 69, 0.9);">
                <div class="ui container" style="margin:40px;">
                    <h2 class="ui header">
                        <div class="content">
                            <span style="font-size:30px; font-weight:300; font-family:Open Sans;">
                                <span style="font-weight:600;">
                                    Test
                                </span>
                                Result
                            </span>
                            <div>
                                <div class="ui active indicating progress" data-percent="33" style="margin-top:10px;">
                                    <xsl:attribute name="data-percent">
                                        <xsl:value-of select="($total_successful div ($total_failures + $total_errors + $total_successful)) * 100">
                                        </xsl:value-of>
                                    </xsl:attribute>
                                    <div class="bar" style="width:33%">
                                        <xsl:attribute name="style">
                                            <xsl:value-of select="concat('width:', ($total_successful div ($total_failures + $total_errors + $total_successful)) * 100, '%;')">
                                            </xsl:value-of>
                                        </xsl:attribute>
                                    </div>
                                </div>
                            </div>
                            <div class="ui divider">
                            </div>
                            <div class="sub header" style="margin-top: 15px;">
                                <div class="ui mini statistics">
                                    <div class="statistic" data-tooltip="Total tests ran">
                                        <div class="value">
                                            <i class="folder open outline icon gray" style="padding-right:4px;">
                                            </i>
                                            <xsl:value-of select="$total_tests">
                                            </xsl:value-of>
                                        </div>
                                        <div class="label">
                                            Tests
                                        </div>
                                    </div>
                                    <div class="statistic" data-tooltip="Total successful test runs">
                                        <div class="value">
                                            <i class="check circle outline icon green" style="padding-right:4px;">
                                            </i>
                                            <xsl:value-of select="$total_successful">
                                            </xsl:value-of>
                                        </div>
                                        <div class="label">
                                            Passed
                                        </div>
                                    </div>
                                    <div class="statistic" data-tooltip="Total test runs with failed assertions">
                                        <div class="value">
                                            <i class="exclamation circle icon red" style="padding-right:4px;">
                                            </i>
                                            <xsl:value-of select="$total_failures">
                                            </xsl:value-of>
                                        </div>
                                        <div class="label">
                                            Failed
                                        </div>
                                    </div>
                                    <div class="statistic" data-tooltip="Total test runs with unanticipated errors">
                                        <div class="value">
                                            <i class="flag outline icon orange" style="padding-right:4px;">
                                            </i>
                                            <xsl:value-of select="$total_errors">
                                            </xsl:value-of>
                                        </div>
                                        <div class="label">
                                            Errored
                                        </div>
                                    </div>
                                    <div class="statistic" data-tooltip="Total runtime for all tests">
                                        <div class="value">
                                            <i class="hourglass half icon blue" style="padding-right:4px;">
                                            </i>
                                            <xsl:value-of select="format-number($total_time div 60, '00')">
                                            </xsl:value-of>
                                            <span style="text-transform:lowercase; font-size:12px;">
                                                min
                                            </span>
                                        </div>
                                        <div class="label">
                                            Runtime
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </h2>
                    <div class="ui styled fluid accordion" style="font-size: 16px; font-family: Open sans;">
                        <xsl:for-each select="//testsuite">
                            <xsl:variable name="suite_total_tests" select="sum(./@tests[number(.) = number(.)])">
                            </xsl:variable>
                            <xsl:variable name="suite_total_errors" select="sum(./@errors[number(.) = number(.)])">
                            </xsl:variable>
                            <xsl:variable name="suite_total_skipped" select="sum(./@skipped[number(.) = number(.)])">
                            </xsl:variable>
                            <xsl:variable name="suite_total_failures" select="sum(./@failures[number(.) = number(.)])">
                            </xsl:variable>
                            <xsl:variable name="suite_total_successful" select="$suite_total_tests - ($suite_total_errors + $suite_total_failures)">
                            </xsl:variable>
                            <xsl:variable name="suite_total_time" select="sum(./testcase/@time[number(.) = number(.)])">
                            </xsl:variable>
                            <div class="title">
                                <i class="angle right icon">
                                </i>
                                <b style="font-family: Lato; font-size: 15px; color: #2f2f2f; font-weight: bold;">
                                    <xsl:value-of select="@name">
                                    </xsl:value-of>
                                </b>
                                <!-- Time Label -->
                                <div class="ui blue label" data-tooltip="Test suite runtime" style="float:right;">
                                    <i class="clock icon">
                                    </i>
                                    <b>
                                        <xsl:value-of select="format-number($suite_total_time, '#.###')">
                                        </xsl:value-of>
                                    </b>
                                    sec
                                </div>
                                <div class="ui label" style="border: 1px solid #80808045;">
                                    <b>
                                        Test Suite
                                    </b>
                                </div>
                                <!-- Test Suite Labels -->
                                <xsl:choose>
                                    <xsl:when test="$suite_total_failures > 0">
                                        <div class="ui red label" data-tooltip="Total test runs with failed assertions" style="float:right;">
                                            <i class="exclamation circle icon">
                                            </i>
                                            <b>
                                                <xsl:value-of select="$suite_total_failures">
                                                </xsl:value-of>
                                            </b>
                                            failed
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="$suite_total_errors > 0">
                                        <div class="ui orange label" data-tooltip="Total test runs with unanticipated errors" style="float:right;">
                                            <i class="flag outline icon">
                                            </i>
                                            <b>
                                                <xsl:value-of select="$suite_total_errors">
                                                </xsl:value-of>
                                            </b>
                                            errored
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:choose>
                                    <xsl:when test="$suite_total_successful > 0">
                                        <div class="ui green label" data-tooltip="Total successful test runs" style="float:right;">
                                            <i class="check circle outline icon">
                                            </i>
                                            <b>
                                                <xsl:value-of select="$suite_total_successful">
                                                </xsl:value-of>
                                            </b>
                                            passed
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                                <!-- Skipped Label -->
                                <xsl:choose>
                                    <xsl:when test="$suite_total_skipped > 0">
                                        <div class="ui gray label" data-tooltip="Total number of skipped tests" style="float:right;     border: 1px solid gray;">
                                            <i class="ban icon">
                                            </i>
                                            <b>
                                                <xsl:value-of select="$suite_total_skipped">
                                                </xsl:value-of>
                                            </b>
                                            skipped
                                        </div>
                                    </xsl:when>
                                </xsl:choose>
                                <div class="ui active indicating progress" data-percent="33" style="margin-top:10px;">
                                    <xsl:attribute name="data-percent">
                                        <xsl:value-of select="($suite_total_successful div ($suite_total_failures + $suite_total_errors + $suite_total_successful)) * 100">
                                        </xsl:value-of>
                                    </xsl:attribute>
                                    <div class="bar" style="width:33%">
                                        <xsl:attribute name="style">
                                            <xsl:value-of select="concat('width:', ($suite_total_successful div ($suite_total_failures + $suite_total_errors + $suite_total_successful)) * 100, '%;')">
                                            </xsl:value-of>
                                        </xsl:attribute>
                                    </div>
                                </div>
                            </div>
                            <div class="content">
                                <div class="accordion" style="background-color:#00000017;">
                                    <xsl:for-each-group group-by="@classname" select="./testcase">
                                        <xsl:variable name="class_total_tests" select="count(current-group())">
                                        </xsl:variable>
                                        <xsl:variable name="class_total_errors" select="count(current-group()/error)">
                                        </xsl:variable>
                                        <xsl:variable name="class_total_failures" select="count(current-group()/failure)">
                                        </xsl:variable>
                                        <xsl:variable name="class_total_skipped" select="count(current-group()/skipped)">
                                        </xsl:variable>
                                        <xsl:variable name="class_total_successful" select="$class_total_tests - ($class_total_errors + $class_total_failures)">
                                        </xsl:variable>
                                        <xsl:variable name="class_total_time" select="sum(current-group()/@time[number(.) = number(.)])">
                                        </xsl:variable>
                                        <div class="title">
                                            <i class="dropdown icon">
                                            </i>
                                            <b>
                                                <xsl:value-of select="current-grouping-key()">
                                                </xsl:value-of>
                                            </b>
                                            <!-- Time Label -->
                                            <div class="ui blue label" data-tooltip="Test class runtime" style="float:right;">
                                                <i class="clock icon">
                                                </i>
                                                <b>
                                                    <xsl:value-of select="format-number($class_total_time, '#.###')">
                                                    </xsl:value-of>
                                                </b>
                                                sec
                                            </div>
                                            <div class="ui label" style="background-color: rgba(255, 255, 255, 0.66); border: 1px solid #bbb6b6;">
                                                <b>
                                                    Test Class
                                                </b>
                                            </div>
                                            <!-- Skipped Label -->
                                            <xsl:choose>
                                                <xsl:when test="$class_total_skipped > 0">
                                                    <div class="ui gray label" data-tooltip="Total number of skipped tests" style="float:right; border: 1px solid gray;">
                                                        <i class="ban icon">
                                                        </i>
                                                        <b>
                                                            <xsl:value-of select="$class_total_skipped">
                                                            </xsl:value-of>
                                                        </b>
                                                        skipped
                                                    </div>
                                                </xsl:when>
                                            </xsl:choose>
                                            <!-- Test Results Labels -->
                                            <xsl:choose>
                                                <xsl:when test="$class_total_successful = $class_total_tests">
                                                    <div class="ui green label" data-tooltip="Total successful test runs" style="float:right;">
                                                        <i class="check circle outline icon">
                                                        </i>
                                                        <b>
                                                            <xsl:value-of select="$class_total_successful">
                                                            </xsl:value-of>
                                                        </b>
                                                    </div>
                                                </xsl:when>
                                                <xsl:when test="$class_total_failures > 0">
                                                    <div class="ui red label" data-tooltip="Total test runs with failed assertions" style="float:right;">
                                                        <i class="exclamation circle icon">
                                                        </i>
                                                        <b>
                                                            <xsl:value-of select="$class_total_failures">
                                                            </xsl:value-of>
                                                        </b>
                                                    </div>
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:choose>
                                                <xsl:when test="$class_total_errors > 0">
                                                    <div class="ui orange label" data-tooltip="Total test runs with unanticipated errors" style="float:right;">
                                                        <i class="flag outline icon">
                                                        </i>
                                                        <b>
                                                            <xsl:value-of select="$class_total_errors">
                                                            </xsl:value-of>
                                                        </b>
                                                    </div>
                                                </xsl:when>
                                            </xsl:choose>
                                            <div class="ui active indicating progress" data-percent="33" style="margin-top:10px;">
                                                <xsl:attribute name="data-percent">
                                                    <xsl:value-of select="($class_total_successful div ($class_total_failures + $class_total_errors + $class_total_successful)) * 100">
                                                    </xsl:value-of>
                                                </xsl:attribute>
                                                <div class="bar" style="width:33%">
                                                    <xsl:attribute name="style">
                                                        <xsl:value-of select="concat('width:', ($class_total_successful div ($class_total_failures + $class_total_errors + $class_total_successful)) * 100, '%;')">
                                                        </xsl:value-of>
                                                    </xsl:attribute>
                                                </div>
                                            </div>
                                        </div>
                                        <div class=" content">
                                            <div class="accordion">
                                                <xsl:for-each select="current-group()">
                                                    <xsl:variable name="sanitized_test_name" select="encode-for-uri(@name)">
                                                    </xsl:variable>
                                                    <xsl:variable name="hasContent" select="boolean(boolean(./failure/@message) = boolean(0) and boolean(./error/@message) = boolean(0) and boolean(./system-out) = boolean(0) and boolean(./error) = boolean(0) and boolean(./system-err) = boolean(0) and boolean(./system-out) = boolean(0)) = boolean(0)">
                                                    </xsl:variable>
                                                    <xsl:variable name="cursor">
                                                        <xsl:if test="not($hasContent)">
                                                             <xsl:text>cursor:default;</xsl:text>
                                                        </xsl:if>
                                                    </xsl:variable>
                                                    <div class="title">
                                                        <xsl:attribute name="style">
                                                            <xsl:choose>
                                                                <xsl:when test="boolean(./failure)">
                                                                    <xsl:value-of select="concat('color:#212121; background-color:rgb(255, 156, 156); ', $cursor)"/>
                                                                </xsl:when>
                                                                <xsl:when test="boolean(./error)">
                                                                    <xsl:value-of select="concat('color:#212121; background-color:#ffa468;' , $cursor)"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="concat('color:#212121; background-color:#baf3b7;' , $cursor)"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:attribute>
                                                        <xsl:choose>
                                                            <xsl:when test="boolean($hasContent)">
                                                                <i class="angle down icon" style="color:#5f5f5f; margin-right:15px;">
                                                                </i>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <i class="check circle outline icon" style="color:#5f5f5f; margin-right:15px;">
                                                                </i>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <span style="font-family: Open Sans; font-weight: 300;">
                                                            <b style="font-family: Lato; font-weight: bold;">
                                                                <xsl:value-of select="@name">
                                                                </xsl:value-of>
                                                            </b>
                                                        </span>
                                                        <!-- Time Label -->
                                                        <div class="ui blue label" data-tooltip="Test runtime" style="float:right;">
                                                            <i class="clock icon">
                                                            </i>
                                                            <xsl:variable name="test_run_time" select="format-number(@time, '#.###')">
                                                            </xsl:variable>
                                                            <xsl:choose>
                                                                <xsl:when test="substring($test_run_time,1,5) = '.0'">
                                                                    <b>
                                                                        ~ 0
                                                                    </b>
                                                                    sec
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <b>
                                                                        <xsl:value-of select="$test_run_time">
                                                                        </xsl:value-of>
                                                                    </b>
                                                                    sec
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </div>
                                                        <xsl:choose>
                                                            <xsl:when test="boolean(./failure/@type)">
                                                                <div class="ui red label" data-tooltip="Exception/Error type" style="float:right;">
                                                                    <i class="exclamation triangle icon">
                                                                    </i>
                                                                    <xsl:value-of select="./failure/@type">
                                                                    </xsl:value-of>
                                                                </div>
                                                            </xsl:when>
                                                            <xsl:when test="boolean(./error/@type)">
                                                                <div class="ui orange label" data-tooltip="Exception/Error type" style="float:right;">
                                                                    <i class="exclamation triangle icon">
                                                                    </i>
                                                                    <xsl:value-of select="./error/@type">
                                                                    </xsl:value-of>
                                                                </div>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </div>
                                                    <xsl:variable name="hasContent" select="boolean(boolean(./failure/@message) = boolean(0) and boolean(./error/@message) = boolean(0) and boolean(./system-out) = boolean(0) and boolean(./error) = boolean(0) and boolean(./system-err) = boolean(0) and boolean(./system-out) = boolean(0)) = boolean(0)">
                                                    </xsl:variable>
                                                    <xsl:choose>
                                                        <xsl:when test="boolean($hasContent)">
                                                            <div class="content">
                                                                <xsl:attribute name="style">
                                                                    <xsl:choose>
                                                                        <xsl:when test="boolean(./failure)">
                                                                            <xsl:value-of select="'background-color:rgb(255, 156, 156);'">
                                                                            </xsl:value-of>
                                                                        </xsl:when>
                                                                        <xsl:when test="boolean(./error)">
                                                                            <xsl:value-of select="'background-color:#ffa468;'">
                                                                            </xsl:value-of>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="'background-color:#baf3b7;'">
                                                                            </xsl:value-of>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:attribute>
                                                                <div style="background-color:rgb(243,243,243);border-radius:7px; padding: 25px;">
                                                                    <xsl:choose>
                                                                        <xsl:when test="string-length(./failure/@message) > 2000">
                                                                            <p  class="errorMessage failureColor">
                                                                                    <xsl:value-of select="substring(./failure/@message, 0, 1999)">
                                                                                    </xsl:value-of>
                                                                                    ...
                                                                            </p>
                                                                        </xsl:when>
                                                                        <xsl:when test="string-length(./failure/@message) > 0">
                                                                            <p class="errorMessage failureColor">
                                                                                    <xsl:value-of select="./failure/@message">
                                                                                    </xsl:value-of>
                                                                            </p>
                                                                        </xsl:when>
                                                                    </xsl:choose>
                                                                    <xsl:choose>
                                                                        <xsl:when test="string-length(./error/@message) > 2000">
                                                                            <p class="errorMessage errorColor">
                                                                                    <xsl:value-of select="substring(./error/@message, 0, 1999)">
                                                                                    </xsl:value-of>...
                                                                            </p>
                                                                        </xsl:when>
                                                                        <xsl:when test="string-length(./error/@message) > 0">
                                                                            <p class="errorMessage errorColor">
                                                                                    <xsl:value-of select="./error/@message">
                                                                                    </xsl:value-of>
                                                                            </p>
                                                                        </xsl:when>
                                                                    </xsl:choose>
                                                                    <div class="ui segment" style="padding-top: 15; background-color: #ffffff00; box-shadow: none; border: none;">
                                                                        <div class="ui menu top" style="background-color: transparent; box-shadow: none; border: none;">
                                                                            <xsl:choose>
                                                                                <xsl:when test="boolean(./failure) and string-length('./failure') > 0">
                                                                                    <a class="active item" style="border-bottom: 3px solid #00000042; font-weight: bolder;">
                                                                                        <xsl:attribute name="data-tab">
                                                                                            <xsl:value-of select="concat('failure_', $sanitized_test_name)">
                                                                                            </xsl:value-of>
                                                                                        </xsl:attribute>
                                                                                        Failure
                                                                                    </a>
                                                                                </xsl:when>
                                                                            </xsl:choose>
                                                                            <xsl:choose>
                                                                                <xsl:when test="boolean(./system-err) and string-length('./system-err') > 1">
                                                                                    <a style="border-bottom: 3px solid #00000042; font-weight: bolder;">
                                                                                        <xsl:attribute name="data-tab">
                                                                                            <xsl:value-of select="concat('syserr_', $sanitized_test_name)">
                                                                                            </xsl:value-of>
                                                                                        </xsl:attribute>
                                                                                        <xsl:attribute name="class">
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="(boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1) and (boolean(./error) = boolean(0) or string-length('./error') &lt; 1)">
                                                                                                    active item
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    item
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </xsl:attribute>
                                                                                        System-err
                                                                                    </a>
                                                                                </xsl:when>
                                                                            </xsl:choose>
                                                                            <xsl:choose>
                                                                                <xsl:when test="boolean(./error) and string-length('./error') > 0">
                                                                                    <a style="border-bottom: 3px solid #00000042; font-weight: bolder;">
                                                                                        <xsl:attribute name="data-tab">
                                                                                            <xsl:value-of select="concat('error_', $sanitized_test_name)">
                                                                                            </xsl:value-of>
                                                                                        </xsl:attribute>
                                                                                        <xsl:attribute name="class">
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1">
                                                                                                    active item
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    item
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                        </xsl:attribute>
                                                                                        Error
                                                                                    </a>
                                                                                </xsl:when>
                                                                            </xsl:choose>
                                                                            <xsl:choose>
                                                                            	<xsl:when test="boolean(./system-out) and string-length('./system-out') > 0">
		                                                                            <a style="border-bottom: 3px solid #00000042; font-weight: bolder;">
		                                                                                <xsl:attribute name="data-tab">
		                                                                                    <xsl:value-of select="concat('sysout_', $sanitized_test_name)">
		                                                                                    </xsl:value-of>
		                                                                                </xsl:attribute>
		                                                                                <xsl:attribute name="class">
		                                                                                    <xsl:choose>
		                                                                                        <xsl:when test="(boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1) and (boolean(./error) = boolean(0) or string-length('./error') &lt; 1) and (boolean(./system-err) = boolean(0) or string-length('./system-err') &lt; 1)">
		                                                                                            active item
		                                                                                        </xsl:when>
		                                                                                        <xsl:otherwise>
		                                                                                            item
		                                                                                        </xsl:otherwise>
		                                                                                    </xsl:choose>
		                                                                                </xsl:attribute>
		                                                                                System-out
		                                                                            </a>
                                                                        		</xsl:when>
                                                                    		</xsl:choose>
                                                                        </div>
                                                                        <xsl:choose>
                                                                            <xsl:when test="boolean(./failure) and string-length('./failure') > 0">
                                                                                <div class="ui tab active">
                                                                                    <xsl:attribute name="data-tab">
                                                                                        <xsl:value-of select="concat('failure_', $sanitized_test_name)">
                                                                                        </xsl:value-of>
                                                                                    </xsl:attribute>
                                                                                    <pre class="prettyprint" style=" overflow: scroll;padding: 20px; max-height: 400px; border: 1px solid #80808054; background-color: white;">
								            								<code><xsl:value-of select="./failure"></xsl:value-of></code>
								            							</pre>
                                                                                </div>
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:choose>
                                                                            <xsl:when test="boolean(./error) and string-length('./error') > 0">
                                                                                <div>
                                                                                    <xsl:attribute name="data-tab">
                                                                                        <xsl:value-of select="concat('error_', $sanitized_test_name)">
                                                                                        </xsl:value-of>
                                                                                    </xsl:attribute>
                                                                                    <xsl:attribute name="class">
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1">
                                                                                                ui tab active
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                ui tab
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </xsl:attribute>
                                                                                    <pre class="prettyprint" style=" overflow: scroll;padding: 20px; max-height: 400px; border: 1px solid #80808054; background-color: white;">
									            							<code><xsl:value-of select="./error"></xsl:value-of></code>
									            						</pre>
                                                                                </div>
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:choose>
                                                                            <xsl:when test="boolean(./system-err) and string-length('./system-err') > 0">
                                                                                <div>
                                                                                    <xsl:attribute name="data-tab">
                                                                                        <xsl:value-of select="concat('syserr_', $sanitized_test_name)">
                                                                                        </xsl:value-of>
                                                                                    </xsl:attribute>
                                                                                    <xsl:attribute name="class">
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="(boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1) and (boolean(./error) = boolean(0) or string-length('./error') &lt; 1)">
                                                                                                ui tab active
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                ui tab
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </xsl:attribute>
                                                                                    <pre class="prettyprint" style=" overflow: scroll;padding: 20px; max-height: 400px; border: 1px solid #80808054; background-color: white;">
								            								<code><xsl:value-of select="./system-err"></xsl:value-of></code>
								            							</pre>
                                                                                </div>
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:choose>
                                                                            <xsl:when test="boolean(./system-out) and string-length('./system-out') > 0">
                                                                                <div>
                                                                                    <xsl:attribute name="data-tab">
                                                                                        <xsl:value-of select="concat('sysout_', $sanitized_test_name)">
                                                                                        </xsl:value-of>
                                                                                    </xsl:attribute>
                                                                                    <xsl:attribute name="class">
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="(boolean(./failure) = boolean(0) or string-length('./failure') &lt; 1) and (boolean(./error) = boolean(0) or string-length('./error') &lt; 1) and (boolean(./system-err) = boolean(0) or string-length('./system-err') &lt; 1)">
                                                                                                ui tab active
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                ui tab
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </xsl:attribute>
                                                                                    <pre class="prettyprint" style=" overflow: scroll;padding: 20px; max-height: 400px; border: 1px solid #80808054; background-color:white;">
							            										<code><xsl:value-of select="./system-out"></xsl:value-of></code>
							            									</pre>
                                                                                </div>
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <div class="content" style="padding:0px;">
                                                            </div>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                            </div>
                                        </div>
                                    </xsl:for-each-group>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
                <script>
                    $(document).ready(function(){
						$('.ui.accordion').accordion();
						$('.top.menu .item').tab();
					});
                </script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>