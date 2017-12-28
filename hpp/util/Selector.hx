package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Selector
{
	public static function firstNotNull(args:Array<Dynamic>):Dynamic
	{
		var result:Dynamic = null;

		for (entry in args)
			if (entry != null) return entry;

		return result;
	}
}