package view;

import h2d.Flow;
import h2d.Sprite;
import hpp.heaps.ui.LinkedButton;
import hxd.Res;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Menu extends Flow
{
	var buttons:Array<LinkedButton> = [];

	public function new(parent:Sprite, openStageSample:Void->Void, openUISample:Void->Void)
	{
		super(parent);

		horizontalSpacing = 20;

		createButton("Stage settings", openStageSample);
		createButton("UI", openUISample);

		buttons[0].linkToButtonList(buttons);
		buttons[0].isSelected = true;
	}

	function createButton(labelText:String, callback:Void->Void)
	{
		var button = new LinkedButton(
			this,
			function(_) {callback();},
			labelText,
			Res.image.button_big.toTile(),
			Res.image.button_big_over.toTile(),
			Res.image.button_big_selected.toTile(),
			Res.image.button_big_selected.toTile()
		);
		button.label.textColor = 0x000000;

		buttons.push(button);
	}
}