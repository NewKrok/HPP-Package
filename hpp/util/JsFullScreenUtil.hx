package hpp.util;

import js.html.Element;

/**
 * ...
 * @author Krisztian Somoracz
 */
class JsFullScreenUtil
{
	public static function init(containerId:String):Void
	{
		#if (js || html5)
			untyped __js__('
				window.hppGameContainer = document.getElementById(containerId);
				window.hppToggleFullScreen = function (targetElement)
				{
					var isInFullScreen = window.innerHeight == screen.height;

					if (isInFullScreen)
					{
						window.hppCancelFullScreen(document);
					}
					else
					{
						window.hppRequestFullScreen(targetElement);
					}
				}

				window.hppRequestFullScreen = function (targetElement)
				{
					var requestMethod = targetElement.requestFullScreen || targetElement.webkitRequestFullScreen || targetElement.mozRequestFullScreen || targetElement.msRequestFullscreen;

					if (requestMethod)
					{
						requestMethod.call(targetElement);
					}
					else if (typeof window.ActiveXObject !== "undefined")
					{
						var wscript = new ActiveXObject("WScript.Shell");
						if (wscript !== null)
						{
							wscript.SendKeys("{F11}");
						}
					}
				}

				window.hppCancelFullScreen = function (targetElement)
				{
					var requestMethod = targetElement.cancelFullScreen || targetElement.webkitCancelFullScreen || targetElement.mozCancelFullScreen || targetElement.exitFullscreen;
					
					if (requestMethod)
					{
						requestMethod.call(targetElement);
					}
					else if (typeof window.ActiveXObject !== "undefined")
					{
						var wscript = new ActiveXObject("WScript.Shell");
						if (wscript !== null)
						{
							wscript.SendKeys("{F11}");
						}
					}
					else
					{
						document.webkitExitFullscreen();
					}
				}
			');
		#end
	}
	
	public static function toggleFullScreen():Void
	{
		#if (js || html5)
			untyped __js__("window.hppToggleFullScreen(window.hppGameContainer);");
		#end
	}
	
	public static function requestFullScreen():Void
	{
		#if (js || html5)
			untyped __js__("window.hppRequestFullScreen(window.hppGameContainer);");
		#end
	}
	
	public static function cancelFullScreen():Void
	{
		#if (js || html5)
			untyped __js__("window.hppCancelFullScreen(window.hppGameContainer);");
		#end
	}
	
	public static function isFullScreen():Bool
	{
		#if (js || html5)
			return untyped __js__("window.innerHeight == screen.height");
		#end
	}
}