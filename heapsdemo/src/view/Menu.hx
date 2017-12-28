package view;

import h2d.Flow;
import h2d.Sprite;
import hpp.heaps.ui.LinkedButton;
import hpp.heaps.ui.TextWithSize;
import hxd.Res;
import hxd.res.FontBuilder;

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
		verticalAlign = FlowAlign.Middle;

		var label:TextWithSize = new TextWithSize(FontBuilder.getFont("Verdana", 12), this);
		label.text = "Change sub state:";

		createButton("Stage settings", openStageSample);
		createButton("UI", openUISample);

		buttons[0].linkToButtonList(buttons);
		buttons[0].isSelected = true;
	}

	function createButton(labelText:String, callback:Void->Void)
	{
		var button = new LinkedButton(
			this,
			{
				onClick: function(_) { callback(); },
				labelText: labelText,
				textColor: 0x000000,
				baseGraphic: Res.image.button_big.toTile(),
				overGraphic: Res.image.button_big_over.toTile(),
				selectedGraphic: Res.image.button_big_selected.toTile(),
				disabledGraphic: Res.image.button_big_selected.toTile()
			}
		);

		buttons.push(button);
	}
}