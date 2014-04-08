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

<style>
.taglib-user-display {
	display: inline-block;
}

.taglib-user-display .user-pop-up dl {
    margin-bottom:5px;
    margin-top:5px
}

.taglib-user-display .user-pop-up dd {
	margin-left: 0;
}

.taglib-user-display .user-pop-up {
    padding: 15px; 
}

.taglib-user-display .user-pop-up .friend-image {
    float: none;
}

.taglib-user-display .user-pop-up .friend-image > img{
    width: 36px;
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
	<a href="<%= url %>">
		<span class="user-profile-image">
			<img alt="<%= taglibAlt %>" class="avatar" src="<%= HtmlUtil.escape(taglibSrc) %>" width="65" />
		</span>

		<span class="user-name">
			<%= (userDisplay != null) ? HtmlUtil.escape(userDisplay.getFullName()) : HtmlUtil.escape(userName) %>
		</span>
	</a>
	
	<div class="user-details">
	
		<%
		boolean showCommonFriends = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_COMMON_FRIENDS, GetterUtil.getBoolean(PropsUtil.get(HOVER_USER_INFO_COMMON_FRIENDS)));
		boolean showEmailAddress = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_EMAIL_ADDRESS, GetterUtil.getBoolean(PropsUtil.get(HOVER_USER_INFO_EMAIL_ADDRESS)));
		boolean showFriends = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_FRIENDS, GetterUtil.getBoolean(PropsUtil.get(HOVER_USER_INFO_FRIENDS)));
		boolean showPhoneNumber = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_PHONE_NUMBER, GetterUtil.getBoolean(PropsUtil.get(HOVER_USER_INFO_PHONE_NUMBER)));
		final int FRIEND_IMAGES_COUNT = GetterUtil.getInteger(PropsUtil.get(HOVER_USER_INFO_IMAGES_COUNT));
		boolean showPopUp = GetterUtil.getBoolean(PropsUtil.get(HOVER_USER_INFO_SHOW));
		
		if (showPopUp && !showCommonFriends && !showEmailAddress && !showFriends && !showPhoneNumber) {
			showPopUp = false;
		}
		%>
		<c:if test="<%= showPopUp %>">
		
			<div class="user-pop-up hidden">
			
				<dl>
					<c:if test="<%= showEmailAddress %>">
						<%List<EmailAddress> emails = userDisplay.getEmailAddresses();%>
						<c:if test="<%= !emails.isEmpty() %>">
							<dt><liferay-ui:message key="email-address"/></dt>
							<dd>
								<%for (EmailAddress email : emails) { %>
									<c:if test="<%= email.isPrimary() %>">
										<aui:a href="mailto:<%= HtmlUtil.escape(email.getAddress()) %>">
											<span><%= HtmlUtil.escape(email.getAddress()) %></span>
										</aui:a>
									</c:if>
								<%}%>
							</dd>
						</c:if>
					</c:if>
					
					<c:if test="<%= showPhoneNumber %>">
						<%List<Phone> phones = userDisplay.getPhones();%>
						<c:if test="<%= !phones.isEmpty() %>">
							<dt>
								<c:choose>
									<c:when test="<%= phones.size() > 2 %>">
										<liferay-ui:message key="phone-numbers" />
									</c:when>
									<c:otherwise>
										<liferay-ui:message key="phone-number" />
									</c:otherwise>
								</c:choose>
							</dt>
							<dd>
								<%for (Phone phone : phones) {%>
									<c:if test="<%= phone.isPrimary() %>">
										<span><%= phone.getNumber() %> <%= phone.getExtension() %> <%= LanguageUtil.get(pageContext, phone.getType().getName()) %></span>
									</c:if>
								<%}%>
							</dd>
						</c:if>
					</c:if>
					
					<c:if test="<%= showFriends %>">
						<%
						List<User> friends = UserLocalServiceUtil.getSocialUsers(userId, SocialRelationConstants.TYPE_BI_FRIEND, 0, FRIEND_IMAGES_COUNT, new UserLoginDateComparator());
						int friendsCount = UserLocalServiceUtil.getSocialUsersCount(userId, SocialRelationConstants.TYPE_BI_FRIEND);
						%>
						<dt><liferay-ui:message key="friends" />&nbsp;<%= HtmlUtil.escape("("+friendsCount+")") %></dt>
						<c:choose>
							<c:when test="<%= friendsCount > 0 %>">
								<dd class="friends">
									<%
									for (User friend : friends) {
										String friendImagePath = friend.getPortraitURL(themeDisplay);
										String friendAlt = HtmlUtil.escapeAttribute(friend.getFullName());
										String friendUrl = friend.getDisplayURL(themeDisplay);
									%>
									<aui:a href="<%= friendUrl %>">
										<span class="friend-image">
											<img alt="<%= friendAlt %>" title="<%= HtmlUtil.escape(friend.getFullName())  %>" class="avatar" src="<%= HtmlUtil.escape(friendImagePath) %>"/>
										</span>
									</aui:a>
									<%
									}
									%>
									<div class="clearfix"></div>
								</dd>
							</c:when>
							<c:otherwise>
								<dd><liferay-ui:message key="no-friends"/></dd>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<c:if test="<%= showCommonFriends && themeDisplay.getUserId() != userId %>">
						<%
						List<User> commonFriends = UserLocalServiceUtil.getSocialUsers(userId, themeDisplay.getUserId(), SocialRelationConstants.TYPE_BI_FRIEND, 0, FRIEND_IMAGES_COUNT, new UserLoginDateComparator());
						int commonFriendsCount = UserLocalServiceUtil.getSocialUsersCount(userId, themeDisplay.getUserId(), SocialRelationConstants.TYPE_BI_FRIEND);
						%>
						<dt><liferay-ui:message key="common-friends" />&nbsp;<%= HtmlUtil.escape("("+commonFriendsCount+")") %></dt>
						<c:choose>
							<c:when test="<%= commonFriendsCount > 0 %>">
								<dd class="common-friends">
									<%
									for (User friend : commonFriends) {
										String friendImagePath = friend.getPortraitURL(themeDisplay);
										String friendAlt = HtmlUtil.escapeAttribute(friend.getFullName());
										String friendUrl = friend.getDisplayURL(themeDisplay);
									%>
										<aui:a href="<%= friendUrl %>">
											<span class="friend-image">
												<img alt="<%= friendAlt %>" title="<%= HtmlUtil.escape(friend.getFullName())  %>" class="avatar small-avatar" src="<%= HtmlUtil.escape(friendImagePath) %>" />
											</span>
											
										</aui:a>
									<%
									}
									%>
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