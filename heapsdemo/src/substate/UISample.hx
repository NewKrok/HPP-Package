package substate;

import h2d.Flow;
import h2d.Layers;
import h2d.Tile;
import h2d.col.Bounds;
import hpp.heaps.Base2dSubState;
import hpp.heaps.ui.BaseButton;
import hpp.heaps.ui.LinkedButton;
import view.SubContent;

/**
 * ...
 * @author Krisztian Somoracz
 */
class UISample extends Base2dSubState
{
	var content:Flow;

	override function build()
	{
		super.build();

		content = new Flow(container);
		content.verticalSpacing = 20;
		content.horizontalSpacing = 20;
		content.layout = Horizontal;
		content.verticalAlign = FlowAlign.Top;
		content.multiline = true;

		createButtonPanel();
		createLinkedButtonPanel();
	}

	override public function onOpen()
	{
		super.onOpen();

		rePosition();
	}

	override public function onStageResize(width:Float, height:Float)
	{
		rePosition();
	}

	function rePosition()
	{
		var size:Bounds = content.getSize();

		content.x = stage.width / 2 - size.width / 2;
		content.y = stage.height / 2 - size.height / 2;
	}

	function createButtonPanel():Void
	{
		var subContent:SubContent = new SubContent(content, 195, "Buttons");

		new BaseButton(
			subContent,
			{
				onClick: function(_) {},
				labelText: "Default button style"
			}
		);

		new BaseButton(
			subContent,
			{
				onClick: function(_) {},
				labelText: "Custom button style",
				textColor: 0xFFFF00,
				fontSize: 17,
				baseGraphic: Tile.fromColor(0xAA0000, 175, 50),
				overGraphic: Tile.fromColor(0xFF0000, 175, 50),
			}
		);
	}

	function createLinkedButtonPanel():Void
	{
		var subContent:SubContent = new SubContent(content, 195, "Linked buttons");

		var firstButton:LinkedButton = new LinkedButton(
			subContent,
			{
				onClick: function(_) {},
				labelText: "Linked Button 1",
				isSelected: true
			}
		);

		var secondButton:LinkedButton = new LinkedButton(
			subContent,
			{
				onClick: function(_) {},
				labelText: "Linked Button 2"
			}
		);
		firstButton.linkToButton(secondButton);

		var thirdButton:LinkedButton = new LinkedButton(
			subContent,
			{
				onClick: function(_) {},
				labelText: "Linked Button 3"
			}
		);
		firstButton.linkToButton(thirdButton);
	}
}