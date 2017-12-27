package view;

import h2d.Sprite;
import h2d.Text.Align;
import h2d.col.Bounds;
import hpp.heaps.ui.LinkedButton;
import hxd.Res;
import hxd.res.FontBuilder;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Checkbox extends LinkedButton
{
	public function new(parent:Sprite, labelText:String, callback:Void->Void)
	{
		super(
			parent,
			function(_) { callback(); },
			labelText,
			Res.image.checkbox.toTile(),
			Res.image.checkbox_over.toTile(),
			Res.image.checkbox_selected.toTile(),
			null,
			FontBuilder.getFont("Verdana", 15)
		);

		isSelectable = true;
		label.textAlign = Align.Left;
		textOffset.x = 45;
		updateView();
	}

	override public function getSize(?Bounds):Bounds
	{
		var result:Bounds = super.getSize(out);

		result.width = 200;

		return result;
	}
}