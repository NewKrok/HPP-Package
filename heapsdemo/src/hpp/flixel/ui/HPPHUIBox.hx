package hpp.flixel.ui;

import hpp.flixel.ui.HPPUIBox;
import hpp.ui.OrderType;
import hpp.ui.VAlign;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPHUIBox extends HPPUIBox
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
		for(child in group)
		{
			child.y = y;
		}
	}
	
	function setVerticalAlignMiddle():Void
	{
		for(child in group)
		{
			child.y = y + height / 2 - child.height / 2;
		}
	}
	
	function setVerticalAlignBottom():Void
	{
		for(child in group)
		{
			child.y = y + height - child.height;
		}
	}
}