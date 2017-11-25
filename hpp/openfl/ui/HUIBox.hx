package hpp.openfl.ui;

import hpp.ui.OrderType;
import hpp.ui.VAlign;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HUIBox extends UIBox
{
	var verticalAlign(default, set):VAlign;
	
	public function new(gap:Float = 0, ?verticalAlign:VAlign) 
	{
		this.verticalAlign = verticalAlign == null ? VAlign.MIDDLE : verticalAlign;
		
		super(gap, OrderType.HORIZONTAL);
	}
	
	function set_verticalAlign(value:VAlign):VAlign 
	{
		verticalAlign = value;
		
		orderByVertical();
		
		return verticalAlign;
	}
	
	override function orderByHorizontal():Void
	{
		if (canOrder())
		{
			super.orderByHorizontal();
			
			switch(verticalAlign)
			{
				case VAlign.TOP:
					setVerticalAlignTop();
					
				case VAlign.MIDDLE:
					setVerticalAlignMiddle();
					
				case VAlign.BOTTOM:
					setVerticalAlignBottom();
			}
		}
	}
		
	function setVerticalAlignTop():Void
	{
		for (i in 0...numChildren)
		{
			getChildAt(i).y = 0;
		}
	}
	
	function setVerticalAlignMiddle():Void
	{
		for (i in 0...numChildren)
		{
			var child:DisplayObject = getChildAt(i);
			child.y = y + height / 2 - child.height / 2;
		}
	}
	
	function setVerticalAlignBottom():Void
	{
		for (i in 0...numChildren)
		{
			var child:DisplayObject = getChildAt(i);
			child.y = y + height - child.height;
		}
	}
}