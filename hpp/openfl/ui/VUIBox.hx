package hpp.openfl.ui;

import hpp.openfl.ui.UIBox;
import hpp.ui.HAlign;
import hpp.ui.OrderType;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Krisztian Somoracz
 */
class VUIBox extends UIBox
{
	var horizontalAlign( default, set ):HAlign;
	
	public function new( gap:Float = 0, ?horizontalAlign:HAlign ) 
	{
		this.horizontalAlign = horizontalAlign == null ? HAlign.CENTER : horizontalAlign;
		
		super( gap, OrderType.VERTICAL );
	}
	
	function set_horizontalAlign( value:HAlign ):HAlign 
	{
		horizontalAlign = value;
		
		orderByVertical();
		
		return horizontalAlign;
	}
	
	override function orderByVertical():Void
	{
		if ( canOrder() )
		{
			super.orderByVertical();
			
			switch( horizontalAlign )
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
		for (i in 0...numChildren)
		{
			getChildAt(i).x = 0;
		}
	}
	
	function setHorizontalAlignCenter():Void
	{
		for (i in 0...numChildren)
		{
			var child:DisplayObject = getChildAt(i);
			child.x = x + width / 2 - child.width / 2;
		}
	}
	
	function setHorizontalAlignRight():Void
	{
		for (i in 0...numChildren)
		{
			var child:DisplayObject = getChildAt(i);
			child.x = x + width - child.width;
		}
	}
}