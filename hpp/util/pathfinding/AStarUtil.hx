package hpp.util.pathfinding;

import hpp.util.GeomUtil.SimplePoint;

/**
 * ...
 * @author Krisztian Somoracz
 */
class AStarUtil
{
	static var width:UInt;
	static var height:UInt;

	static var start:Node;
	static var goal:Node;
	static var map:Array<Array<Node>>;
	static var open:Array<Node>;
	static var closed:Array<Node>;

	static inline var COST_ORTHOGONAL:Float = 1;
	static inline var COST_DIAGONAL:Float = 1.414;

	public static function getPath(pathRequest:PathRequest):Path
	{
		map = pathRequest.mapNodes;

		var xPos:UInt = 0;
		var yPos:UInt = 0;
		for (row in map)
		{
			for (node in row)
			{
				node.x = xPos++;
				node.y = yPos;
			}
			xPos = 0;
			yPos++;
		}

		width = map[ 0 ].length;
		height = map.length;

		start = map[ cast pathRequest.startPosition.y ][ cast pathRequest.startPosition.x ];
		goal = map[ cast pathRequest.endPosition.y ][ cast pathRequest.endPosition.x ];

		open = [];
		closed = [];

		var node:Node = start;
		node.g = 0;
		node.h = euclidian(node);
		node.f = node.g + node.h;

		while(node != goal)
		{
			var startY:Int = cast Math.max(0, node.x > 0 ? node.x - 1 : 0);
			var endY:Int = cast Math.min(width - 1, node.x + 1) + 1;
			var startX:Int = cast Math.max(0, node.y > 0 ? node.y - 1 : 0);
			var endX:Int = cast Math.min(height - 1, node.y + 1) + 1;

			var test:Node;
			for(i in startX...endX)
			{
				for(j in startY...endY)
				{
					test = map[ i ][ j ];
					if(test == node || !test.isWalkable)
					{
						continue;
					}

					var cost:Float = COST_ORTHOGONAL;
					if(!((node.x == test.x) || (node.y == test.y)))
					{
						cost = COST_DIAGONAL;
					}
					var g:Float = node.g + cost;
					var h:Float = euclidian(test);
					var f:Float = g + h;

					if(isOpen(test) || isClosed(test))
					{
						if(test.f > f)
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
						}
					}
					else
					{
						test.f = f;
						test.g = g;
						test.h = h;
						test.parent = node;
						open.push(test);
					}
				}
			}
			closed.push(node);
			if(open.length == 0)
			{
				trace("no path found");
				return null;
			}

			open.sort(sortVector);
			node = open.shift();
		}

		var solution:Array<SimplePoint> = [];
		solution.push({ x: node.x, y: node.y });

		while(node.parent != null && node.parent != start)
		{
			node = node.parent;
			solution.push({ x: node.x, y: node.y });
		}

		var path:Path = solution;
		path.reverse();

		return path;
	}

	static function sortVector(x:Node, y:Node):Int
	{
		return (x.f >= y.f) ? 1 : -1;
	}

	static function euclidian(node:Node):Float
	{
		var dx:Float = node.x - goal.x;
		var dy:Float = node.y - goal.y;
		return Math.sqrt(dx * dx + dy * dy) * COST_ORTHOGONAL;
	}

	static function isClosed(node:Node):Bool
	{
		for(i in 0...closed.length)
		{
			if(closed[ i ] == node)
			{
				return true;
			}
		}
		return false;
	}

	static function isOpen(node:Node):Bool
	{
		for(i in 0...open.length)
		{
			if(open[ i ] == node)
			{
				return true;
			}
		}
		return false;
	}
}

class Node
{
	public var h:Float = 0;
	public var g:Float = 0;
	public var f:Float = 0;
	public var parent:Node;

	public var x:UInt;
	public var y:UInt;

	public var isWalkable:Bool = true;

	public function new(isWalkable:Bool)
	{
		this.isWalkable = isWalkable;
	}
}

typedef Path = Array<SimplePoint>;

typedef PathRequest = {
	var startPosition:SimplePoint;
	var endPosition:SimplePoint;
	var mapNodes:Array<Array<Node>>;
}