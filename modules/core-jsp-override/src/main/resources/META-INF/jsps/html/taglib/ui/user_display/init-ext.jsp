<%
String randomNamespace = PortalUtil.generateRandomKey(request, "taglib_ui_user_display") + StringPool.UNDERLINE;
%>

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

<aui:script use="aui-tooltip">  
	A.on('domready', function() {
		var srcNode = A.one('#<%=randomNamespace %>taglib-user-display-hovercard');
	    var triggerNode = A.one('#<%=randomNamespace %>taglib-user-display');
	    srcNode.removeClass('hidden');
	    var tooltip = new A.Tooltip({
	        trigger: triggerNode,
	        position: 'right',
	        zIndex: Liferay.zIndex.TOOLTIP,
	        srcNode: srcNode,
	        opacity: 0.9
	    }).render();
	    tooltip.hide();
	});
</aui:script>
<div class="hovercard-wrapper">
	<div id="<%=randomNamespace %>taglib-user-display-hovercard" class="hovercard hidden">
		<div class="card">
			<div class="card-block text-center">
				<h3>Joe Bloggs</h3>
				<h5 class="text-default">joe.bloggs@rivetlogic.com</h5>
				<strong>Phone Number</strong>
				<h5 class="text-default">+292-029-123213 Business</h5>
				<strong>Friends (3)</strong>
				<div class="portraits-list">
					<div class="user-icon user-icon-default"><span>JB</span></div>
					<div class="user-icon user-icon-default"><span>JB</span></div>
				</div>
				<strong>Common Friends (1)</strong>
				<div class="portraits-list">
					<div class="user-icon user-icon-default"><span>JB</span></div>
					<div class="user-icon user-icon-default"><span>JB</span></div>
				</div>
			</div>
		</div>
	</div>
</div>
