<%-- CUSTOM start --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.liferay.portal.kernel.service.UserLocalServiceUtil" %>
<%@ page import="com.liferay.social.kernel.model.SocialRelationConstants" %>
<%@ page import="com.liferay.portal.kernel.util.comparator.UserLoginDateComparator" %>
<%
	final String HOVER_USER_INFO_SHOW = "hover.user.info.show";
	final String HOVER_USER_INFO_COMMON_FRIENDS = "hover.user.info.common.friends";
	final String HOVER_USER_INFO_EMAIL_ADDRESS = "hover.user.info.email.address";
	final String HOVER_USER_INFO_FRIENDS = "hover.user.info.friends";
	final String HOVER_USER_INFO_PHONE_NUMBER = "hover.user.info.phone.number";
	final String HOVER_USER_INFO_IMAGES_COUNT = "hover.user.info.friends.images";
    
	long companyId = company.getCompanyId(); 
	
	boolean showCommonFriends = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_COMMON_FRIENDS, true);
	boolean showEmailAddress = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_EMAIL_ADDRESS, true);
	boolean showFriends = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_FRIENDS, true);
	boolean showPhoneNumber = PrefsPropsUtil.getBoolean(companyId, HOVER_USER_INFO_PHONE_NUMBER, true);
	final int FRIEND_IMAGES_COUNT = 5;
	boolean showPopUp = true;

	if (showPopUp && !showCommonFriends && !showEmailAddress && !showFriends && !showPhoneNumber) {
		showPopUp = false;
	}

	String randomNamespace = PortalUtil.generateRandomKey(request, "taglib_ui_user_display")
			+ StringPool.UNDERLINE;
%>
<%-- <pre>
    custom initialization
    -showPopUp <%=showPopUp %>
</pre> --%>
<style>
.hovercard-wrapper .tooltip {
	max-width: 400px;
}

.hovercard-wrapper .tooltip-inner {
	color: inherit;
	max-width: none;
	padding: 0;
}

.hovercard-wrapper .portraits-list {
	margin: 0 0 5px
}

.hovercard-wrapper .portraits-list .user-icon {
	display: inline-block;
	margin: 0 1px;
}
</style>
<c:if test="<%= showPopUp %>">
	<aui:script use="aui-tooltip">
		A.on('domready', function() {
			var srcNode = A
					.one('#<%=randomNamespace %>taglib-user-display-hovercard');
			var triggerNode = A.one('#<%=randomNamespace %>taglib-user-display');
			srcNode.removeClass('hidden');
			var tooltip = new A.Tooltip({
				trigger : triggerNode,
				position : 'right',
				zIndex : Liferay.zIndex.TOOLTIP,
				srcNode : srcNode,
				opacity : 0.9
			}).render();
			tooltip.hide();
		});
	</aui:script> 

	<div class="hovercard-wrapper">
		<div id="<%=randomNamespace%>taglib-user-display-hovercard"
			class="hovercard hidden">
			<div class="card">
				<div class="card-block text-center">
					<h3><%= (userDisplay != null) ? userDisplay.getFullName() : userName %></h3>
					<c:if test="<%= showEmailAddress %>">
                        <h5 class="text-default">
                            <aui:a href="mailto:<%= userDisplay.getDisplayEmailAddress()%>"><%= userDisplay.getDisplayEmailAddress()%></aui:a>
                        </h5>
					</c:if>
					<c:if test="<%= showPhoneNumber %>">
					    <c:set var="phones" value="<%= userDisplay.getPhones() %>"/>
					    <c:if test="${not empty phones}">
					        <c:choose>
	                            <c:when test="${fn:length(phones) gt 1}">
	                               <strong><liferay-ui:message key="phone-numbers" /></strong>
	                            </c:when>
	                            <c:otherwise>
	                               <strong><liferay-ui:message key="phone-number" /></strong>
	                            </c:otherwise>
                            </c:choose>
                            <c:forEach items="${phones}" var="phone">
								<c:if test="${phone.primary}">
									<c:set var="phoneTypeName" value="${phone.type.name}" />
									<h5 class="text-default">${phone.number} ${phone.extension} <%=LanguageUtil.get(locale,
										(String) pageContext.getAttribute("phoneTypeName"))%>
									</h5>
								</c:if>
							</c:forEach>
					    </c:if>
					</c:if> 
					<c:if test="<%= showFriends %>">
					    <c:set var="friends"
                            value="<%=UserLocalServiceUtil.getSocialUsers(userDisplay.getUserId(),
                            SocialRelationConstants.TYPE_BI_FRIEND, 0,
                            FRIEND_IMAGES_COUNT, new UserLoginDateComparator()) %>" />
                        <c:set var="friendsCount"
                            value="<%=UserLocalServiceUtil.getSocialUsersCount(userDisplay.getUserId(),
                            SocialRelationConstants.TYPE_BI_FRIEND)%>" />
						<strong><liferay-ui:message key="friends" /> (${fn:escapeXml(friendsCount)})</strong>
						<div class="portraits-list">
							<c:choose>
								<c:when test="${friendsCount gt 0}">
									<c:forEach items="${friends}" var="friend">
										<c:set var="friendUrl"
											value="<%=((User) pageContext.getAttribute(\"friend\")).getDisplayURL(themeDisplay)%>" />
										<a href="${friendUrl}" title="${friend.fullName}">
											<liferay-ui:user-portrait cssClass="user-icon-sm"
												user="${friend}" userName="${friend.getFullName()}" />
										</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
								    <liferay-ui:message key="no-friends"/>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
					<c:if test="<%= showCommonFriends && themeDisplay.getUserId() != userDisplay.getUserId() %>">
						<c:set var="commonFriends"
							value="<%=UserLocalServiceUtil.getSocialUsers(userDisplay.getUserId(), themeDisplay.getUserId(),
							SocialRelationConstants.TYPE_BI_FRIEND, 0, FRIEND_IMAGES_COUNT,
							new UserLoginDateComparator())%>" />
						<c:set var="commonFriendsCount"
                            value="<%=UserLocalServiceUtil.getSocialUsersCount(userDisplay.getUserId(),
                            themeDisplay.getUserId(),
                            SocialRelationConstants.TYPE_BI_FRIEND)%>" />
                            
						<strong><liferay-ui:message key="common-friends" /> (${ fn:escapeXml(commonFriendsCount) })</strong>
						<div class="portraits-list">
							<c:choose>
                                <c:when test="${commonFriendsCount gt 0}">
                                    <c:forEach items="${commonFriends}" var="commonFriend">
                                        <c:set var="friendUrl"
                                            value="<%=((User) pageContext.getAttribute(\"commonFriend\")).getDisplayURL(themeDisplay)%>" />
                                        <a href="${friendUrl}" title="${commonFriend.fullName}">
                                            <liferay-ui:user-portrait cssClass="user-icon-sm"
                                                user="${commonFriend}" userName="${commonFriend.getFullName()}" />
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <liferay-ui:message key="no-common-friends"/>
                                </c:otherwise>
                            </c:choose>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</c:if>
<%-- CUSTOM end --%>