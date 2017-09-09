package hpp.flixel.ui;

import hpp.flixel.ui.HPPUIBox;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPVUIBox extends HPPUIBox
{
	var horizontalAlign( default, set ):HPPVUIBoxAlign;
	
	public function new( gap:Float = 0, horizontalAlign:HPPVUIBoxAlign = HPPVUIBoxAlign.CENTER ) 
	{
		this.horizontalAlign = horizontalAlign;
		
		super( gap, HPPUIBoxOrder.VERTICAL );
	}
	
	function set_horizontalAlign( value:HPPVUIBoxAlign ):HPPVUIBoxAlign 
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
				case HPPVUIBoxAlign.LEFT:
					setHorizontalAlignLeft();
					
				case HPPVUIBoxAlign.CENTER:
					setHorizontalAlignCenter();
					
				case HPPVUIBoxAlign.RIGHT:
					setHorizontalAlignRight();
			}
		}
	}
		
	function setHorizontalAlignLeft():Void
	{
		for( child in group )
		{
			child.x = x;
		}
	}
	
	function setHorizontalAlignCenter():Void
	{
		for( child in group )
		{
			child.x = x + width / 2 - child.width / 2;
		}
	}
	
	function setHorizontalAlignRight():Void
	{
		for( child in group )
		{
			child.x = x + width - child.width;
		}
	}
}

@:enum
abstract HPPVUIBoxAlign( String ) {
	var LEFT = "left";
	var CENTER = "center";
	var RIGHT = "right";
}