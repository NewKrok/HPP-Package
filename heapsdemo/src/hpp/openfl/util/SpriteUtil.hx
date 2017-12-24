package hpp.openfl.util;

import hpp.util.GeomUtil.SimplePoint;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.geom.Point;

/**
 * ...
 * @author Krisztian Somoracz
 */
class SpriteUtil 
{
	public static function getDistance(targetA:DisplayObject, targetB:DisplayObject):Float
	{
		return Point.distance(new Point(targetA.x, targetA.y), new Point(targetB.x, targetB.y));
	}
	
	public static function getAngle(targetA:DisplayObject, targetB:DisplayObject):Float
	{
		return Math.atan2(targetB.y - targetA.y, targetB.x - targetA.x);
	}
	
	public static function getContextPosition(positionContext:DisplayObjectContainer, target:DisplayObject):SimplePoint
	{
		var result:SimplePoint = { x: target.x, y: target.y };
		
		while (target.parent != null && target.parent != positionContext)
		{
			result.x += target.parent.x;
			result.y += target.parent.y;
			target = target.parent;
		}
		
		return result;
	}
}