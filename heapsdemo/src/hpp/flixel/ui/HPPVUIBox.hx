package hpp.flixel.ui;

import hpp.flixel.ui.HPPUIBox;
import hpp.ui.HAlign;
import hpp.ui.OrderType;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPVUIBox extends HPPUIBox
{
	var horizontalAlign(default, set):HAlign;
	
	public function new(gap:Float = 0, ?horizontalAlign:HAlign) 
	{
		this.horizontalAlign = horizontalAlign == null ? HAlign.CENTER : horizontalAlign;
		
		super(gap, OrderType.VERTICAL);
	}
	
	function set_horizontalAlign(value:HAlign):HAlign 
	{
		horizontalAlign = value;
		
		orderByVertical();
		
		return horizontalAlign;
	}
	
	override function orderByVertical():Void
	{
		if (canOrder())
		{
			super.orderByVertical();
			
			switch(horizontalAlign)
			{
				case HAlign.LEFT:
					setHorizontalAlignLeft();
					
				case HAlign.CENTER:
					setHorizontalAlignCenter();
					
				case HAlign.RIGHT:
					setHorizontalAlignRight();
			}
		}
	}
		
	function setHorizontalAlignLeft():Void
	{
		for(child in group)
		{
			child.x = x;
		}
	}
	
	function setHorizontalAlignCenter():Void
	{
		for(child in group)
		{
			child.x = x + width / 2 - child.width / 2;
		}
	}
	
	function setHorizontalAlignRight():Void
	{
		for(child in group)
		{
			child.x = x + width - child.width;
		}
	}
}