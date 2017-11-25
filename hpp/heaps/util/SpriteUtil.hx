package hpp.heaps.util;

import h2d.Sprite;
import h2d.col.Point;

/**
 * ...
 * @author Krisztian Somoracz
 */
class SpriteUtil 
{
	public static function getDistance(targetA:Sprite, targetB:Sprite):Float
	{
		return new Point(targetA.x, targetA.y).distance(new Point(targetB.x, targetB.y));
	}
}