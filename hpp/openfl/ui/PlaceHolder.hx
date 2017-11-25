package hpp.openfl.ui;

import openfl.display.Sprite;

/**
 * ...
 * @author Krisztian Somoracz
 */
class PlaceHolder extends Sprite
{
	public function new(width:Int, height:Int, color:UInt = 0x000000, alpha:Float = 0) 
	{
		super();
		
		graphics.beginFill(color, alpha);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}
}