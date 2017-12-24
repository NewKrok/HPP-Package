package hpp.openfl.ui;

import hpp.ui.VAlign;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author Krisztian Somoracz
 */
class UIFlow extends Sprite
{
	public var maxWidth(default, set):Float;
	public var horizontalGap(default, set):Float;
	public var verticalGap(default, set):Float;
	public var verticalAlign(default, set):VAlign;
	public var rowHeight(default, set):Float;
	
	var isInitProcessEnded:Bool;
	
	public function new(maxWidth:Float, horizontalGap:Float = 0, verticalGap:Float = 0, ?verticalAlign:VAlign, ?rowHeight:Float) 
	{
		super();
		
		isInitProcessEnded = false;
		
		this.maxWidth = maxWidth;
		this.horizontalGap = horizontalGap;
		this.verticalGap = verticalGap;
		this.verticalAlign = verticalAlign == null ? VAlign.MIDDLE : verticalAlign;
		this.rowHeight = rowHeight;
		
		isInitProcessEnded = true;
	}
	
	public function rePosition():Void
	{
		orderElements();
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
			var nextChildXPosition:Float = 0;
			var nextChildYPosition:Float = 0;
			var row:Array<DisplayObject> = [];
			var col:UInt = 0;
			
			for (i in 0...numChildren)
			{
				var child:DisplayObject = getChildAt(i);
				col++;
				
				if (nextChildXPosition + child.width > maxWidth)
				{
					nextChildXPosition = 0;
					col = 0;
					var calculatedRowHeight:Float = calculateRowHeight(row);
					orderRow(nextChildYPosition, calculatedRowHeight, row);
					
					nextChildYPosition += calculatedRowHeight + verticalGap;
					row = [];
				}
				
				child.x = nextChildXPosition;
				nextChildXPosition += child.width + horizontalGap;
				row.push(child);
			}
			
			if (col > 0)
			{
				var calculatedRowHeight:Float = calculateRowHeight(row);
				orderRow(nextChildYPosition, calculatedRowHeight, row);
			}
		}
	}
	
	function calculateRowHeight(row:Array<DisplayObject>):Float
	{
		if (rowHeight != null) return rowHeight;
		
		var result:Float = 0;
		
		for (child in row)
		{
			if (child.height > result) result = child.height;
		}
		
		return result;
	}
	
	function orderRow(baseYOffset:Float, calculatedRowHeight:Float, row:Array<DisplayObject>):Void
	{
		switch (verticalAlign)
		{
			case VAlign.TOP: setVerticalAlignTop(baseYOffset, row);
			case VAlign.MIDDLE: setVerticalAlignMiddle(baseYOffset, calculatedRowHeight, row);
			case VAlign.BOTTOM: setVerticalAlignBottom(baseYOffset, calculatedRowHeight, row);
		}
	}
	
	function setVerticalAlignTop(baseYOffset:Float, row:Array<DisplayObject>):Void
	{
		for (child in row)
		{
			child.y = baseYOffset;
		}
	}
	
	function setVerticalAlignMiddle(baseYOffset:Float, calculatedRowHeight:Float, row:Array<DisplayObject>):Void
	{
		for (child in row)
		{
			child.y = baseYOffset + calculatedRowHeight / 2 - child.height / 2;
		}
	}
	
	function setVerticalAlignBottom(baseYOffset:Float, calculatedRowHeight:Float, row:Array<DisplayObject>):Void
	{
		for (child in row)
		{
			child.y = baseYOffset + calculatedRowHeight - child.height;
		}
	}
	
	function set_maxWidth(value:Float):Float 
	{
		maxWidth = value <= 0 ? 1 : value;
		
		orderElements();
		
		return maxWidth;
	}
	
	function set_verticalAlign(value:VAlign):VAlign 
	{
		verticalAlign = value;
		
		orderElements();
		
		return verticalAlign;
	}
	
	function set_horizontalGap(value:Float):Float 
	{
		horizontalGap = value;
		
		orderElements();
		
		return horizontalGap;
	}
	
	function set_verticalGap(value:Float):Float 
	{
		verticalGap = value;
		
		orderElements();
		
		return verticalGap;
	}
	
	function set_rowHeight(value:Float):Float 
	{
		rowHeight = value;
		
		orderElements();
		
		return rowHeight;
	}
}