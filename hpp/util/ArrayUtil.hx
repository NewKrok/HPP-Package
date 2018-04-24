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

	public static function shuffle(a:Array<Dynamic>):Array<Dynamic>
	{
		for (i in 0...a.length)
		{
			var rndIndex = Math.floor(Math.random() * a.length);
			var tempObj = a[i];
			a[i] = a[rndIndex];
			a[rndIndex] = tempObj;
		}

		return a;
	}
}