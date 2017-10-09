package hpp.flixel.ui;

import flixel.FlxSprite;

/**
 * ...
 * @author Krisztian Somoracz
 */
class PlaceHolder extends FlxSprite
{
	public function new(width:Int, height:Int, color:UInt = 0x00000000) 
	{
		super();
		
		makeGraphic(width, height, color);
	}
}