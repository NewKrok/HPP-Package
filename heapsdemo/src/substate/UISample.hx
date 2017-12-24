package substate;

import h2d.Layers;
import h2d.col.Bounds;
import hpp.heaps.Base2dSubState;
import hpp.heaps.ui.BaseButton;

/**
 * ...
 * @author Krisztian Somoracz
 */
class UISample extends Base2dSubState
{
	var content:Layers;

	override function build()
	{
		super.build();

		content = new Layers(container);

		new BaseButton(
			content,
			function(_) {},
			"Button Sample"
		);
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
}