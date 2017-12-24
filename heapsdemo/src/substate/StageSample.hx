package substate;

import h2d.Flow;
import h2d.col.Bounds;
import hpp.heaps.Base2dStage.StageScaleMode;
import hpp.heaps.Base2dSubState;
import hpp.heaps.ui.BaseButton;

/**
 * ...
 * @author Krisztian Somoracz
 */
class StageSample extends Base2dSubState
{
	var content:Flow;

	override function build()
	{
		super.build();

		content = new Flow(container);
		content.verticalSpacing = 20;
		content.isVertical = true;

		new BaseButton(
			content,
			function(_) { stage.stageScaleMode = StageScaleMode.NO_SCALE; },
			"NO_SCALE"
		);

		new BaseButton(
			content,
			function(_) { stage.stageScaleMode = StageScaleMode.SHOW_ALL; },
			"SHOW_ALL"
		);

		new BaseButton(
			content,
			function(_) { stage.stageScaleMode = StageScaleMode.EXACT_FIT; },
			"EXACT_FIT"
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