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

<%@ include file="/html/taglib/ui/user_display/init.jsp" %>

<%
if (Validator.isNull(url) && (userDisplay != null)) {
	url = userDisplay.getDisplayURL(themeDisplay);
}
%>
<%-- BEGIN Rivet Logic Customization --%>
<style>
.taglib-user-display {
	display: inline-block;
}

.taglib-user-display .user-pop-up dl{
    margin-bottom:5px;
    margin-top:5px
}

.taglib-user-display .user-pop-up {
    padding: 15px; 
}

.taglib-user-display .user-pop-up .user-profile-image{
    float:left;
}

.taglib-user-display .user-pop-up .user-profile-image > img{
    width: 46px;
    height: 46px;
    margin-right:3px;
}

.taglib-user-display .user-pop-up .clearfix {
    clear: both;
    display: block;
}

.taglib-user-display .user-pop-up {
    background-color: #FFFFFF;
    color: #000000;
    border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
}

</style>

<div id="<%=randomNamespace %>taglib-user-display-wrapper" data-title=" " class="taglib-user-display display-style-<%= displayStyle %>">
<%-- END Rivet Logic Customization --%>
	<%
	String taglibAlt = (userDisplay != null) ? HtmlUtil.escapeAttribute(userDisplay.getFullName()) : LanguageUtil.get(pageContext, "generic-portrait");

	String taglibSrc = null;

	if (userDisplay != null) {
		taglibSrc = userDisplay.getPortraitURL(themeDisplay);
	}
	else {
		taglibSrc = UserConstants.getPortraitURL(themeDisplay.getPathImage(), true, 0);
	}
	%>
	<%-- BEGIN Rivet Logic Customization --%>
	<a href="<%= url %>">
	<%-- END Rivet Logic Customization --%>
		<span class="user-profile-image">
			<img alt="<%= taglibAlt %>" class="avatar" src="<%= HtmlUtil.escape(taglibSrc) %>" width="65" />
		</span>

		<span class="user-name">
			<%= (userDisplay != null) ? HtmlUtil.escape(userDisplay.getFullName()) : HtmlUtil.escape(userName) %>
		</span>
	<%-- BEGIN Rivet Logic Customization --%>
 	</a>
 	<%-- END Rivet Logic Customization --%>
	<div class="user-details">
		<%-- BEGIN Rivet Logic Customization --%>
		<%
			boolean showCommonFriends = PrefsPropsUtil.getBoolean(companyId,
					HOVER_USER_INFO_COMMON_FRIENDS, GetterUtil
							.getBoolean(PropsUtil
									.get(HOVER_USER_INFO_COMMON_FRIENDS)));
			boolean showEmailAddress = PrefsPropsUtil.getBoolean(companyId,
					HOVER_USER_INFO_EMAIL_ADDRESS, GetterUtil
							.getBoolean(PropsUtil
									.get(HOVER_USER_INFO_EMAIL_ADDRESS)));
			boolean showFriends = PrefsPropsUtil.getBoolean(companyId,
					HOVER_USER_INFO_FRIENDS, GetterUtil.getBoolean(PropsUtil
							.get(HOVER_USER_INFO_FRIENDS)));
			boolean showPhoneNumber = PrefsPropsUtil.getBoolean(companyId,
					HOVER_USER_INFO_PHONE_NUMBER, GetterUtil
							.getBoolean(PropsUtil
									.get(HOVER_USER_INFO_PHONE_NUMBER)));
			final int FRIEND_IMAGES_COUNT = GetterUtil.getInteger(PropsUtil
					.get(HOVER_USER_INFO_IMAGES_COUNT));
			boolean showPopUp = GetterUtil.getBoolean(PropsUtil
					.get(HOVER_USER_INFO_SHOW));

			if (showPopUp && !showCommonFriends && !showEmailAddress
					&& !showFriends && !showPhoneNumber) {
				showPopUp = false;
			}
		%>
		<c:if test="<%= showPopUp %>">
		
			<div class="user-pop-up hidden">
			
				<dl>
					<c:if test="<%= showEmailAddress %>">
						<c:set var="emails" value="<%= userDisplay.getEmailAddresses() %>"/>
						<c:if test="${not empty emails}">
							<dt><liferay-ui:message key="email-address"/></dt>
							<dd>
								<c:forEach items="${emails}" var="email">
									<c:if test="${email.primary}">
										<aui:a href="mailto: ${ fn:escapeXml(email.address) }">
											<span>${ fn:escapeXml(email.address) }</span>
										</aui:a>
									</c:if>
								</c:forEach>
							</dd>
						</c:if>
					</c:if>
					
					<c:if test="<%= showPhoneNumber %>">
						<c:set var="phones" value="<%= userDisplay.getPhones() %>"/>
						<c:if test="${not empty phones}">
							<dt>
								<c:choose>
									<c:when test="${fn:length(phones) gt 1}">
										<liferay-ui:message key="phone-numbers" />
									</c:when>
									<c:otherwise>
										<liferay-ui:message key="phone-number" />
									</c:otherwise>
								</c:choose>
							</dt>
							<dd>
								<c:forEach items="${phones}" var="phone">
									<c:if test="${phone.primary}">
										<c:set var="phoneTypeName" value="${phone.type.name }" />
										<span> 
											${phone.number} ${phone.extension} <%=LanguageUtil.get(pageContext,
												(String) pageContext.getAttribute("phoneTypeName"))%>
										</span>
									</c:if>
								</c:forEach>
							</dd>
						</c:if>
					</c:if>
					
					<c:if test="<%= showFriends %>">

						<c:set var="friends"
							value="<%=UserLocalServiceUtil.getSocialUsers(userId,
							SocialRelationConstants.TYPE_BI_FRIEND, 0,
							FRIEND_IMAGES_COUNT, new UserLoginDateComparator())%>" />
						<c:set var="friendsCount"
							value="<%=UserLocalServiceUtil.getSocialUsersCount(userId,
							SocialRelationConstants.TYPE_BI_FRIEND)%>" />
						<dt><liferay-ui:message key="friends" />&nbsp;(${ fn:escapeXml(friendsCount) }) </dt>
						<c:choose>
							<c:when test="${friendsCount gt 0}">
								<dd class="friends">
									<c:forEach items="${friends}" var="friend">
										<c:set var="friendImagePath" value="<%= ((User)pageContext.getAttribute(\"friend\")).getPortraitURL(themeDisplay) %>" />
										<c:set var="friendAlt" value="${ fn:escapeXml(friend.fullName) }" />
										<c:set var="friendUrl" value="<%= ((User)pageContext.getAttribute(\"friend\")).getDisplayURL(themeDisplay) %>" />

										<aui:a href="${friendUrl}">
											<span class="user-profile-image">
												<img alt="${friendAlt}" title="${fn:escapeXml(friendAlt)}"
												class="avatar" src="${fn:escapeXml(friendImagePath)}"
												width="65" />
											</span>
										</aui:a>
									</c:forEach>
									
									<div class="clearfix"></div>
								</dd>
							</c:when>
							<c:otherwise>
								<dd><liferay-ui:message key="no-friends"/></dd>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<c:if test="<%= showCommonFriends && themeDisplay.getUserId() != userId %>">

						<c:set var="commonFriends"
							value="<%=UserLocalServiceUtil.getSocialUsers(userId,
							themeDisplay.getUserId(),
							SocialRelationConstants.TYPE_BI_FRIEND, 0,
							FRIEND_IMAGES_COUNT, new UserLoginDateComparator())%>" />
						<c:set var="commonFriendsCount"
							value="<%=UserLocalServiceUtil.getSocialUsersCount(userId,
							themeDisplay.getUserId(),
							SocialRelationConstants.TYPE_BI_FRIEND)%>" />
						<dt><liferay-ui:message key="common-friends" />&nbsp;(${ fn:escapeXml(commonFriendsCount) })</dt>
						<c:choose>
							<c:when test="${commonFriendsCount gt 0}">
								<dd class="common-friends">
									<c:forEach items="${commonFriends}" var="commonFriend" >
										<c:set var="friendImagePath"
											value="<%=((User) pageContext
										.getAttribute(\"commonFriend\"))
										.getPortraitURL(themeDisplay)%>" />
										<c:set var="friendAlt"
											value="${ fn:escapeXml(commonFriend.fullName) }" />
										<c:set var="friendUrl"
											value="<%=((User) pageContext
										.getAttribute(\"commonFriend\"))
										.getDisplayURL(themeDisplay)%>" />

										<aui:a href="${friendUrl}">
											<span class="user-profile-image"> 
												<img alt="${friendAlt}"
													title="${fn:escapeXml(friendAlt)}" class="avatar"
													src="${fn:escapeXml(friendImagePath)}" width="65" />
											</span>
										</aui:a>
									</c:forEach>
								</dd>
							</c:when>
							<c:otherwise>
								<dd><liferay-ui:message key="no-common-friends" /></dd>
							</c:otherwise>
						</c:choose>
						<div class="clearfix"></div>
					</c:if>
				</dl>
			</div>
			
		</c:if>

<aui:script use="aui-tooltip">  
     
     var wrapper = A.one('#<%=randomNamespace %>taglib-user-display-wrapper');
     wrapper.one('.user-pop-up').removeClass('hidden');
     var tooltip = new A.Tooltip({
         trigger: wrapper,
         position: 'right',
         zIndex: Liferay.zIndex.TOOLTIP,
         srcNode: wrapper.one('.user-pop-up'),
         opacity: 0.9
     }).render();
     tooltip.hide();
     
</aui:script>
<%-- END Rivet Logic Customization --%>