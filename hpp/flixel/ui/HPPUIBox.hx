package hpp.flixel.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPUIBox extends FlxSpriteGroup
{
	public var gap( default, set ):Float;
	public var orderType( default, set ):HPPUIBoxOrder;
	
	var isInitProcessEnded:Bool;
	
	public function new( gap:Float = 0, orderType:HPPUIBoxOrder = HPPUIBoxOrder.VERTICAL )
	{
		super();
		
		isInitProcessEnded = false;
		
		this.gap = gap;
		this.orderType = orderType;
		
		isInitProcessEnded = true;
	}
	
	public function rePosition():Void
	{
		orderElements();
	}
	
	override public function add( child:FlxSprite ):FlxSprite
	{
		super.add( child );
		
		orderElements();
		
		return child;
	}
	
	function orderElements():Void
	{
		if( orderType == HPPUIBoxOrder.HORIZONTAL )
		{
			orderByHorizontal();
		}
		else if( orderType == HPPUIBoxOrder.VERTICAL )
		{
			orderByVertical();
		}
	}
	
	function orderByHorizontal():Void
	{
		if ( canOrder() )
		{
			var nextChildPosition:Float = 0;
			
			for( child in group )
			{
				child.x = x + nextChildPosition;
				nextChildPosition += child.width + gap;
			}
		}
	}
	
	function orderByVertical():Void
	{
		if ( canOrder() )
		{
			var nextChildPosition:Float = 0;
			
			for( child in group )
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
	
	function set_orderType( value:HPPUIBoxOrder ):HPPUIBoxOrder 
	{
		orderType = value;
		
		orderElements();
		
		return orderType;
	}
}

@:enum
abstract HPPUIBoxOrder( String ) {
	var HORIZONTAL = "horizontal";
	var VERTICAL = "vertical";
}