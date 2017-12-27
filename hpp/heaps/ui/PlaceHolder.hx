package hpp.heaps.ui;

import h2d.Graphics;
import h2d.Sprite;

/**
 * ...
 * @author Krisztian Somoracz
 */
class PlaceHolder extends Graphics
{
	public function new(?parent:Sprite, width:Float = 1, height:Float = 1, color:Int = 0x000000, alpha:Float = 0)
	{
		super(parent);

		beginFill(color, alpha);
		drawRect(0, 0, width, height);
		endFill();
	}
}