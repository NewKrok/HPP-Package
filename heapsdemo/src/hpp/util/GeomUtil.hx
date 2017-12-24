package hpp.util;

/**
 * ...
 * @author Krisztian Somoracz
 */
class GeomUtil 
{
	public static function getDistance(targetA:SimplePoint, targetB:SimplePoint):Float
	{
		return Math.sqrt(Math.pow(targetA.x - targetB.x, 2) + Math.pow(targetA.y - targetB.y, 2));
	}
	
	public static function getAngle(targetA:SimplePoint, targetB:SimplePoint):Float
	{
		return Math.atan2(targetB.y - targetA.y, targetB.x - targetA.x);
	}
}

typedef SimplePoint = {
	var x:Float;
	var y:Float;
}