<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="s5b" %>
<%@ taglib uri="/WEB-INF/dd.tld" prefix="s5bdd" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en" class="ng-app:application" id="ng-app" data-ng-app="application">

<head>

    <meta charset="utf-8">

    <meta name="application-name" content="CoffeePages"/>

    <link rel="stylesheet" href="<c:url value="/resources/coffee-css/coffee-pages.css" />" type="text/css" />

    <script src="<c:url value="/resources/modernizr/modernizr.custom.55386.js" />"></script>

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!--[if lte IE 8]>
    <script>
        document.createElement('ng-include');
        document.createElement('ng-pluralize');
        document.createElement('ng-view');
        document.createElement('ng:include');
        document.createElement('ng:pluralize');
        document.createElement('ng:view');
    </script>
    <![endif]-->
    <!--[if lt IE 8]>
    <script src="<c:url value="/resources/coffee-js/lib/json3.min.js" />"></script>
    <![endif]-->

    <script type="text/javascript">
        var s5b = s5b || {};
        s5b.location = s5b.location || {};
        s5b.location.contentName       = '${location.contentName}';
        s5b.location.contentId         = '${location.contentId}';
        s5b.location.defaultTabId      = '${location.defaultTabId}';
        s5b.location.defaultCategoryId = '${location.defaultCategoryId}';
        s5b.location.findUsTabId       = '${location.findUsTabId}';
        s5b.location.tabs              = {
            <c:set var="tabSeparator" value="" />
            <c:forEach var="tab" items="${dde.tabs}">
                ${tabSeparator}"${tab.id}": [
                        <c:set var="categorySeparator" value="" />
                        <c:forEach var="category" items="${tab.categories}">
                            ${categorySeparator}"${category.id}"
                            <c:set var="categorySeparator" value="," />
                        </c:forEach>
                ]
                <c:set var="tabSeparator" value="," />
            </c:forEach>
        };
        s5b.location.suburb = '${location.suburb}';
        s5b.location.state  = '${location.state}';
    </script>

    <title>${dde.name} : Business Listing View</title>
    <meta name="description" content="A list of contacts explores the collision between JSP and AngularJS.">

</head>

<body data-ng-controller="s5b.controllers.main">

<header data-ng-cloak class="ng-cloak">
    <h1>${dde.name} : Business Listing</h1>
</header>
<article data-ng-cloak class="ng-cloak">
    <nav class="main">
        <ul><c:forEach var="tab" items="${dde.tabs}"><li><a href='<c:url value="${location.primaryId}#/tab/${tab.id}"/>' data-ng-class="isTabSelected('${tab.id}')">${tab.name}</a></li></c:forEach></ul>
    </nav>

    <c:forEach var="tab" items="${dde.tabs}">
        <section class="main" data-ng-show="isTabSelected('${tab.id}')">
            <c:choose>

                <c:when test='${tab.type == "contact"}'>
                    <nav class="categories">
                        <ul><c:forEach var="category" items="${tab.categories}"><li><a href='<c:url value="${location.primaryId}#/tab/${tab.id}/category/${category.id}"/>' data-ng-class="isCategorySelected('${category.id}')">${category.name}</a></li></c:forEach></ul>
                    </nav>
                    <c:forEach var="category" items="${tab.categories}">
                        <section class="contacts" data-ng-show="isCategorySelected('${category.id}')">
                            <c:choose>
                                <c:when test="${location.defaultTabId == tab.id && location.defaultCategoryId == category.id}">
                                    <s5b:category category="${category}" location="${location}" />
                                </c:when>
                                <c:otherwise>
                                    <div data-s5b-content-replacement='<c:url value="${location.primaryId}/fragment/tab/${tab.id}/category/${category.id}" />'></div>
                                </c:otherwise>
                            </c:choose>
                        </section>
                    </c:forEach>
                    <section class="hyc">
                        <img src='<c:url value="/resources/images/hyc.png" />' alt="hyc"/>
                    </section>
                </c:when>

                <c:when test='${tab.type == "findUs"}'>
                    <div class="locationContainer" data-s5b-content-replacement='<c:url value="${location.primaryId}/fragment/findUs" />'>
                    <%--<div class="locationContainer" >--%>
                        <s5b:findUs associations="${s5bdd:getFilteredAssociations(tab.associations, location.region)}" />
                    </div><div class="mapContainer"><img alt="map" src="<c:url value="/resources/images/mordor.png" />" /></div>
                </c:when>

                <c:otherwise>HUH? Tab type "${tab.type}" is unknown.</c:otherwise>

            </c:choose>
        </section>
    </c:forEach>

</article>
<footer data-ng-cloak class="ng-cloak">
    &copy; 2013 CoffeePages Pty Ltd <a href="https://github.com/s5b/whitepages-seo">(source)</a>
</footer>

<script src="<c:url value="/resources/coffee-js/lib/lodash.min.js" />"></script>
<script src="<c:url value="/resources/coffee-js/lib/angular.min.js" />"></script>
<script src="<c:url value="/resources/coffee-js/application.js" />"></script>

</body>

</html>
