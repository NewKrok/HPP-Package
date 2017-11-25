package hpp.openfl.ui;

import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.geom.Point;

/**
 * ...
 * @author Krisztian Somoracz
 */
class UIGrid extends DisplayObjectContainer
{
	var gridSize(default, set):Point;
	var gridSizeForCalculation:Point;
	
	var verticalGap(default, set):Float;
	var horizontalGap(default, set):Float;
	
	var drawedRow:Int;
	var drawedCol:Int;
	
	var col(default, set):UInt;
	
	var isInitProcessEnded:Bool;
	
	public function new(col:UInt, gap:Float = 0, gridSize:Point = null) 
	{
		super();
		
		isInitProcessEnded = false;
		
		this.col = col;
		this.gridSize = gridSize;
		this.verticalGap = gap;
		this.horizontalGap = gap;
		
		isInitProcessEnded = true;
	}
	
	override public function addChild(child:DisplayObject):DisplayObject 
	{
		super.addChild(child);
		
		orderElements();
		
		return child;
	}
	
	override public function addChildAt(child:DisplayObject, index:Int):DisplayObject 
	{
		super.addChildAt(child, index);
		
		orderElements();
		
		return child;
	}
	
	override public function removeChild(child:DisplayObject):DisplayObject 
	{
		super.removeChild(child);
		
		orderElements();
		
		return child;
	}
	
	override public function removeChildAt(index:Int):DisplayObject 
	{
		var child:DisplayObject = super.removeChildAt(index);
		
		orderElements();
		
		return child;
	}
	
	function orderElements():Void
	{
		if (isInitProcessEnded)
		{
			if (gridSize == null && numChildren > 0)
			{
				var firstChild:DisplayObject = getChildAt(0);
				gridSizeForCalculation = new Point(firstChild.width, firstChild.height);
			}
			
			var currentCol:Int = 0;
			var currentRow:Int = 0;

			for (i in 0...numChildren)
			{
				var child:DisplayObject = getChildAt(i);
				child.x = getColPositionByIndex(currentCol) + gridSizeForCalculation.x / 2 - child.width / 2;
				child.y = getRowPositionByIndex(currentRow) + gridSizeForCalculation.y / 2 - child.height / 2;
				
				currentCol++;
				if (currentCol == col)
				{
					currentCol = 0;
					currentRow++;
				}
			}
			
			drawedRow = currentRow;
			drawedCol = currentCol;
		}
	}
	
	function getRowPositionByIndex(index:UInt):Float
	{
		return index * gridSizeForCalculation.y + index * verticalGap;
	}
	
	function getColPositionByIndex(index:UInt):Float
	{
		return index * gridSizeForCalculation.x + index * horizontalGap;
	}
	
	function set_gridSize(value:Point):Point 
	{
		gridSize = value;
		gridSizeForCalculation = value;
		
		orderElements();
		
		return gridSize;
	}
	
	function set_verticalGap(value:Float):Float 
	{
		verticalGap = value;
		
		orderElements();
		
		return verticalGap;
	}
	
	function set_horizontalGap(value:Float):Float 
	{
		horizontalGap = value;
		
		orderElements();
		
		return horizontalGap;
	}
	
	function set_col(value:UInt):UInt 
	{
		col = value;
		
		orderElements();
		
		return col;
	}
}