package view;

import h2d.Object;
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
	public function new(parent:Object, labelText:String, callback:Void->Void)
	{
		super(
			parent,
			{
				onClick: function(_) { callback(); },
				labelText: labelText,
				textAlign: Align.Left,
				textOffset: { x: 45, y: 0 },
				font: FontBuilder.getFont("Verdana", 15),
				baseGraphic: Res.image.checkbox.toTile(),
				overGraphic: Res.image.checkbox_over.toTile(),
				selectedGraphic: Res.image.checkbox_selected.toTile(),
				isSelectable: true
			}
		);

		updateView();
	}

	override public function getSize(?out:Bounds):Bounds
	{
		var result:Bounds = super.getSize(out);

		result.width = 200;

		return result;
	}
}