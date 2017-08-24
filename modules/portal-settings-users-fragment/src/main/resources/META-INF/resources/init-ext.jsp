<%-- CUSTOM start --%>
<%
final String HOVER_USER_INFO_COMMON_FRIENDS = "hover.user.info.common.friends";
final String HOVER_USER_INFO_EMAIL_ADDRESS = "hover.user.info.email.address";
final String HOVER_USER_INFO_FRIENDS = "hover.user.info.friends";
final String HOVER_USER_INFO_PHONE_NUMBER = "hover.user.info.phone.number";

boolean showCommonFriends = PrefsPropsUtil.getBoolean(company.getCompanyId(), HOVER_USER_INFO_COMMON_FRIENDS, true);
boolean showEmailAddress = PrefsPropsUtil.getBoolean(company.getCompanyId(), HOVER_USER_INFO_EMAIL_ADDRESS, true);
boolean showFriends = PrefsPropsUtil.getBoolean(company.getCompanyId(), HOVER_USER_INFO_FRIENDS, true);
boolean showPhoneNumber = PrefsPropsUtil.getBoolean(company.getCompanyId(), HOVER_USER_INFO_PHONE_NUMBER, true);
%>
<%-- CUSTOM end --%>
<%-- <pre>
    custom initialization
    -showCommonFriends <%=showCommonFriends %>
    -showEmailAddress <%=showEmailAddress %>
    -showFriends <%=showFriends %>
    -showPhoneNumber <%=showPhoneNumber %>
</pre> --%>