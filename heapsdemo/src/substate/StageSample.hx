package substate;

import h2d.Flow;
import h2d.Text;
import h2d.Tile;
import h2d.col.Bounds;
import hpp.heaps.Base2dStage.StagePosition;
import hpp.heaps.Base2dStage.StageScaleMode;
import hpp.heaps.Base2dSubState;
import hpp.heaps.ui.PlaceHolder;
import hxd.res.FontBuilder;
import view.Checkbox;
import view.SubContent;

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
		content.layout = Vertical;

		createStageScalePanel();
		createStagePositionPanel();
	}

	function createStageScalePanel()
	{
		var subContent:SubContent = new SubContent(content, 660, "Change stage scale mode");

		var firstCheckbox:Checkbox = new Checkbox(
			subContent,
			"NO_SCALE",
			function() { stage.stageScaleMode = StageScaleMode.NO_SCALE; }
		);
		firstCheckbox.isSelected = true;

		firstCheckbox.linkToButton(new Checkbox(
			subContent,
			"SHOW_ALL (default stage size: 1136x640)",
			function() { stage.stageScaleMode = StageScaleMode.SHOW_ALL; }
		));

		firstCheckbox.linkToButton(new Checkbox(
			subContent,
			"EXACT_FIT (default stage size: 1136x640)",
			function() { stage.stageScaleMode = StageScaleMode.EXACT_FIT; }
		));
	}

	function createStagePositionPanel()
	{
		var subContent:SubContent = new SubContent(content, 660, "Change stage position (Only for stage 'Show all' mode)");

		var grid:Flow = new Flow(subContent);
		grid.layout = Horizontal;
		grid.maxWidth = subContent.minWidth;
		grid.multiline = true;
		grid.horizontalSpacing = 20;
		grid.verticalSpacing = 10;

		var stagePositions:Array<StagePosition> = [
			StagePosition.LEFT_TOP, StagePosition.CENTER_TOP, StagePosition.RIGHT_TOP,
			StagePosition.LEFT_MIDDLE, StagePosition.CENTER_MIDDLE, StagePosition.RIGHT_MIDDLE,
			StagePosition.LEFT_BOTTOM, StagePosition.CENTER_BOTTOM, StagePosition.RIGHT_BOTTOM
		];

		var firstCheckbox:Checkbox = null;
		for (position in stagePositions)
		{
			var checkbox = new Checkbox(
				grid,
				position.getName(),
				function() { stage.stagePosition = position; }
			);

			if (firstCheckbox == null)
			{
				firstCheckbox = checkbox;
				firstCheckbox.isSelected = true;
			}
			else
			{
				firstCheckbox.linkToButton(checkbox);
			}
		}
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