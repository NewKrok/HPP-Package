package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import hpp.ui.OrderType;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPUIBox extends FlxSpriteGroup
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
	
	override public function add(child:FlxSprite):FlxSprite
	{
		super.add(child);
		
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
			
			for(child in group)
			{
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
			
			for(child in group)
			{
				child.y = y + nextChildPosition;
				nextChildPosition += child.height + gap;
			}
		}
	}
	
	function canOrder():Bool
	{
		return isInitProcessEnded && group != null && group.members.length > 0;
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