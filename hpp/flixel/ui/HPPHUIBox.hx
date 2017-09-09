package hpp.flixel.ui;

import hpp.flixel.ui.HPPUIBox;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPHUIBox extends HPPUIBox
{
	var verticalAlign( default, set ):HPPHUIBoxAlign;
	
	public function new( gap:Float = 0, horizontalAlign:HPPHUIBoxAlign = HPPHUIBoxAlign.MIDDLE ) 
	{
		this.verticalAlign = horizontalAlign;
		
		super( gap, HPPUIBoxOrder.HORIZONTAL );
	}
	
	function set_verticalAlign( value:HPPHUIBoxAlign ):HPPHUIBoxAlign 
	{
		verticalAlign = value;
		
		orderByVertical();
		
		return verticalAlign;
	}
	
	override function orderByHorizontal():Void
	{
		if ( canOrder() )
		{
			super.orderByHorizontal();
			
			switch( verticalAlign )
			{
				case HPPHUIBoxAlign.TOP:
					setVerticalAlignTop();
					
				case HPPHUIBoxAlign.MIDDLE:
					setVerticalAlignMiddle();
					
				case HPPHUIBoxAlign.BOTTOM:
					setVerticalAlignBottom();
			}
		}
	}
		
	function setVerticalAlignTop():Void
	{
		for( child in group )
		{
			child.y = y;
		}
	}
	
	function setVerticalAlignMiddle():Void
	{
		for( child in group )
		{
			child.y = y + height / 2 - child.height / 2;
		}
	}
	
	function setVerticalAlignBottom():Void
	{
		for( child in group )
		{
			child.y = y + height - child.height;
		}
	}
}

@:enum
abstract HPPHUIBoxAlign( String ) {
	var TOP = "top";
	var MIDDLE = "middle";
	var BOTTOM = "bottom";
}