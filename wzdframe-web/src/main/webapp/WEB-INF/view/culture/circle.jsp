<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />

<!-- Website Design By: www.happyworm.com -->
<title>Demo : jPlayer circle player</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="/statics/jquery-video/skin/circle.skin/circle.player.css">
<script type="text/javascript" src="/statics/jquery-video/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.transform2d.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/jquery.grab.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/mod.csstransforms.min.js"></script>
<script type="text/javascript" src="/statics/jquery-video/js/circle.player.js"></script>

<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
	/*
	 * Instance CirclePlayer inside jQuery doc ready
	 *
	 * CirclePlayer(jPlayerSelector, media, options)
	 *   jPlayerSelector: String - The css selector of the jPlayer div.
	 *   media: Object - The media object used in jPlayer("setMedia",media).
	 *   options: Object - The jPlayer options.
	 *
	 * Multiple instances must set the cssSelectorAncestor in the jPlayer options. Defaults to "#cp_container_1" in CirclePlayer.
	 *
	 * The CirclePlayer uses the default supplied:"m4a, oga" if not given, which is different from the jPlayer default of supplied:"mp3"
	 * Note that the {wmode:"window"} option is set to ensure playback in Firefox 3.6 with the Flash solution.
	 * However, the OGA format would be used in this case with the HTML solution.
	 */
	var myCirclePlayer = new CirclePlayer("#jquery_jplayer_1",
	{
		m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
		oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
	}, {
		cssSelectorAncestor: "#cp_container_1",
		swfPath: "js",
		wmode: "window",
		keyEnabled: true
	});
});
//]]>
</script>
</head>
<body>

			<div id="jquery_jplayer_1" class="cp-jplayer"></div>
			<div id="cp_container_1" class="cp-container">
				<div class="cp-buffer-holder"> 
					<div class="cp-buffer-1"></div>
					<div class="cp-buffer-2"></div>
				</div>
				<div class="cp-progress-holder"> 
					<div class="cp-progress-1"></div>
					<div class="cp-progress-2"></div>
				</div>
				<div class="cp-circle-control"></div>
				<ul class="cp-controls">
					<li><a class="cp-play" tabindex="1">播放</a></li>
					<li><a class="cp-pause" style="display:none;" tabindex="1">暂停</a></li>
				</ul>
			</div>

</body>

</html>
