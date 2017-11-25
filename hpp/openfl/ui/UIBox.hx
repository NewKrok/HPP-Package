package hpp.openfl.ui;

import hpp.ui.OrderType;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author Krisztian Somoracz
 */
class UIBox extends DisplayObjectContainer
{
	public var gap(default, set):Float;
	public var orderType(default, set):OrderType;
	
	var isInitProcessEnded:Bool;
	
	public function new(gap:Float = 0, ?orderType:OrderType)
	{
		super();
		
		isInitProcessEnded = false;
		
		this.gap = gap;
		this.orderType = orderType == null ? OrderType.VERTICAL : orderType;
		
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
		if (canOrder())
		{
			if(orderType == OrderType.HORIZONTAL)
			{
				orderByHorizontal();
			}
			else if(orderType == OrderType.VERTICAL)
			{
				orderByVertical();
			}
		}
	}
	
	function orderByHorizontal():Void
	{
		if (canOrder())
		{
			var nextChildPosition:Float = 0;
			
			for(i in 0...numChildren)
			{
				var child:DisplayObject = getChildAt(i);
				child.x = x + nextChildPosition;
				nextChildPosition += child.width + gap;
			}
		}
	}
	
	function orderByVertical():Void
	{
		if (canOrder())
		{
			var nextChildPosition:Float = 0;
			
			for(i in 0...numChildren)
			{
				var child:DisplayObject = getChildAt(i);
				child.y = y + nextChildPosition;
				nextChildPosition += child.height + gap;
			}
		}
	}
	
	function canOrder():Bool
	{
		return isInitProcessEnded;
	}
	
	function set_gap(value:Float):Float 
	{
		gap = value;
		
		orderElements();
		
		return gap;
	}
	
	function set_orderType(value:OrderType):OrderType
	{
		orderType = value;
		
		orderElements();
		
		return orderType;
	}
}