package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class ArrayUtil
{
	public static function random(a:Array<Dynamic>):Dynamic
	{
		return a != null && a.length >= 0 ? a[Math.floor(Math.random() * a.length)] : null;
	}
}