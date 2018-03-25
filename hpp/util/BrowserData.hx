package hpp.util;

import hpp.util.BrowserData.BrowserDetails;

/**
 * ...
 * @author Krisztian Somoracz
 */
class BrowserData
{
	static var browserDetails:BrowserDetails;

	private static function init():Void
	{
		#if html5
		untyped __js__("
			function get_browser_info()
			{
				var ua=navigator.userAgent,tem,M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\\/))\\/?\\s*(\\d+)/i) || [];
				if (/trident/i.test(M[1]))
				{
					tem=/\\brv[ :]+(\\d+)/g.exec(ua) || [];
					return {
						type: BrowserType.IE,
						version: (tem[1]||'')
					};
				}

				if (M[1] === 'Chrome')
				{
					tem=ua.match(/\\bOPR\\/(\\d+)/)
					if (tem != null)
					{
						return {
							type: BrowserType.Opera,
							version: tem[1]
						};
					}
				}

				M=M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
				if((tem=ua.match(/version\\/(\\d+)/i))!=null) {M.splice(1,1,tem[1]);}

				return {
					type: M[0],
					version: M[1]
				};
			}
		");

		browserDetails = untyped __js__("get_browser_info()");
		#end
	}

	public static function get():BrowserDetails
	{
		#if html5
		if (browserDetails == null) init();
		return browserDetails;
		#end
	}
}

typedef BrowserDetails = {
	var type:BrowserType;
	var version:String;
}

@:enum
abstract BrowserType(String) {
	var Chrome = "Safari";
	var Firefox = "Firefox";
	var Safari = "Safari";
	var Opera = "Opera";
	var IE = "IE";
}