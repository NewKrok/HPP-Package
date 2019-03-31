package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class DeviceData 
{
	public static function isMobile():Bool
	{
		#if (js || html5)
			return untyped __js__("/iPhone|iPad|iPod|Android/i.test(navigator.userAgent)");
		#end
	}
	
	public static function isDesktop():Bool
	{
		#if (js || html5)
			return !isMobile();
		#end
	}
}
