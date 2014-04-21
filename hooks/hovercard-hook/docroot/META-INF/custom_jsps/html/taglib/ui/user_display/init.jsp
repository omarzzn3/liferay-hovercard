<%--
/**
 * Copyright (C) 2014 Rivet Logic Corporation. All rights reserved.
 */
 
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/taglib/init.jsp" %>

<%@ page import="com.liferay.portal.model.Address" %>
<%@ page import="com.liferay.portal.model.EmailAddress" %>
<%@ page import="com.liferay.portal.model.Phone" %>
<%@ page import="com.liferay.portlet.social.model.SocialRelationConstants" %>
<%@ page import="com.liferay.portal.util.comparator.UserLoginDateComparator" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.StringPool" %>

<%
String userName = GetterUtil.getString((String)request.getAttribute("liferay-ui:user-display:user-name"));
User userDisplay = (User)request.getAttribute("liferay-ui:user-display:user");
String url = (String)request.getAttribute("liferay-ui:user-display:url");
int displayStyle = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:user-display:displayStyle"));
/* BEGIN Rivet Logic Customization */
final String HOVER_USER_INFO_SHOW = "hover.user.info.show";
final String HOVER_USER_INFO_COMMON_FRIENDS = "hover.user.info.common.friends";
final String HOVER_USER_INFO_EMAIL_ADDRESS = "hover.user.info.email.address";
final String HOVER_USER_INFO_FRIENDS = "hover.user.info.friends";
final String HOVER_USER_INFO_PHONE_NUMBER = "hover.user.info.phone.number";
final String HOVER_USER_INFO_IMAGES_COUNT = "hover.user.info.friends.images";
				
long companyId = themeDisplay.getCompanyId();
long groupId = themeDisplay.getScopeGroupId();
long userId = userDisplay.getUserId();

String randomNamespace = PortalUtil.generateRandomKey(request, "taglib_ui_user_display") + StringPool.UNDERLINE;
/* END Rivet Logic Customization */
%>