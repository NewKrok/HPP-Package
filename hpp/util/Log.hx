package hpp.util;

import hpp.util.TimeUtil;
import js.Browser;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Log
{
	public static var isEnabled:Bool = false;

	public static function info(message:String)
	{
		if (!isEnabled) return;

		Browser.console.info(TimeUtil.timeStampToFormattedTime(Date.now().getTime(), TimeUtil.TIME_FORMAT_HH_MM_SS_MS) + " | " + message);
	}

	public static function warn(message:String)
	{
		if (!isEnabled) return;

		Browser.console.warn(TimeUtil.timeStampToFormattedTime(Date.now().getTime(), TimeUtil.TIME_FORMAT_HH_MM_SS_MS) + " | " + message);
	}

	public static function error(message:String)
	{
		if (!isEnabled) return;

		Browser.console.error(TimeUtil.timeStampToFormattedTime(Date.now().getTime(), TimeUtil.TIME_FORMAT_HH_MM_SS_MS) + " | " + message);
	}
}
