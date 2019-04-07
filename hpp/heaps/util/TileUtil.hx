package hpp.heaps.util;

import h2d.Tile;

/**
 * ...
 * @author Krisztian Somoracz
 */
class TileUtil
{
	public static function getVerticalTile(t:Tile, width:UInt, height:UInt, dx = 0, dy = 0):Array<Tile>
	{
		return [for(y in 0...Std.int(t.height / height)) t.sub(0, y * height, width, height, dx, dy)];
	}

	public static function getHorizontalTile(t:Tile, width:UInt, height:UInt, dx = 0, dy = 0):Array<Tile>
	{
		return [for(x in 0...Std.int(t.width / width)) t.sub(x * width, 0, width, height, dx, dy)];
	}
}
