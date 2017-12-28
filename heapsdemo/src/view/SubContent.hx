package view;

import h2d.Flow;
import h2d.Sprite;
import h2d.Tile;
import hpp.heaps.ui.PlaceHolder;
import hpp.heaps.ui.TextWithSize;
import hxd.res.FontBuilder;

/**
 * ...
 * @author Krisztian Somoracz
 */
class SubContent extends Flow
{
	public function new(parent:Sprite, width:Int, labelText:String)
	{
		super(parent);

		verticalSpacing = 10;
		padding = 10;
		minWidth = width;
		maxWidth = width;
		horizontalAlign = FlowAlign.Left;
		isVertical = true;
		backgroundTile = Tile.fromColor(0x000000, 1, 1, .4);

		var label:TextWithSize = new TextWithSize(FontBuilder.getFont("Verdana", 12), this);
		label.text = labelText;
	}
}