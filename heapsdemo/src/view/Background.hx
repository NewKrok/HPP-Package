package view;

import h2d.Bitmap;
import h2d.Layers;
import h2d.Sprite;
import hxd.Res;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Background extends Layers
{
	var backgroundLogo:Bitmap;

	public function new(parent:Sprite)
	{
		super(parent);

		addChild(backgroundLogo = new Bitmap(Res.image.background_logo.toTile()));
	}

	public function onResize(stageWidth:Float, stageHidth:Float)
	{
		x = stageWidth / 2 - backgroundLogo.tile.width / 2;
		y = stageHidth / 2 - backgroundLogo.tile.height / 2;
	}
}