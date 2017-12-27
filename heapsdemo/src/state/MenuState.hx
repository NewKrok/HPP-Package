package state;

import hpp.heaps.Base2dState;
import substate.StageSample;
import substate.UISample;
import view.Background;
import view.Menu;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MenuState extends Base2dState
{
	var background:Background;
	var menu:Menu;

	var stageSample:StageSample;
	var uiSample:UISample;

	override function build()
	{
		background = new Background(stage);

		stageSample = new StageSample();
		uiSample = new UISample();

		menu = new Menu(
			stage,
			function() { openSubState(stageSample); },
			function() { openSubState(uiSample); }
		);

		rePosition();
		openSubState(stageSample);
	}

	override public function onStageResize(width:Float, height:Float)
	{
		rePosition();

		super.onStageResize(width, height);
	}

	function rePosition()
	{
		menu.x = stage.width / 2 - menu.outerWidth / 2;
		menu.y = 50;

		background.onResize(stage.width, stage.height);
	}
}