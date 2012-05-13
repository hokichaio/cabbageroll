<ul id="scroller"></ul>
<script>
jQuery(function getScrollerContents(){
	jQuery.get("<%= request.getContextPath() %>/async/enqs", function(data) {
        if(data!=null) {
        	jQuery("#scroller").empty().append(data);
            jQuery("#scroller").simplyScroll();
        } else {
        	jQuery("#target").append("NO ENQ!");
        }
    });
	return false;
});
function findenq(enqId){
	jQuery.get("<%= request.getContextPath() %>/goto?enqId=" + enqId, function(data) {
		var content = jQuery(data).find('#cabbage');
        jQuery("#target").empty().append(content);
    });
	
	return false;
}
</script>