package hpp.heaps;

import h2d.Graphics;
import h2d.Layers;
import h2d.Scene;
import h3d.Engine;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dStage extends Layers
{
	public var stageScaleMode(default, set):StageScaleMode = StageScaleMode.NO_SCALE;
	public var stagePosition(default, set):StagePosition = StagePosition.LEFT_TOP;

	public var showStageBorder(default, set):Bool = false;
	public var width(get, never):Float;
	public var height(get, never):Float;
	public var mouseX(get, never):Float;
	public var mouseY(get, never):Float;
	public var defaultWidth:Int = 800;
	public var defaultHeight:Int = 600;

	var stageBorder:Graphics;

	var s2d:Scene;
	var engine:Engine;

	var onStageScaleModeChanged:Void->Void;
	var onStagePositionChanged:Void->Void;

	public function new(s2d:Scene, engine:Engine, onStageScaleModeChanged:Void->Void, onStagePositionChanged:Void->Void)
	{
		super(s2d);

		this.onStageScaleModeChanged = onStageScaleModeChanged;
		this.onStagePositionChanged = onStagePositionChanged;

		this.s2d = s2d;
		this.engine = engine;

		stageBorder = new Graphics(s2d);
	}

	function set_stageScaleMode(value:StageScaleMode):StageScaleMode
	{
		stageScaleMode = value;
		onStageScaleModeChanged();
		return stageScaleMode;
	}

	function set_stagePosition(value:StagePosition):StagePosition
	{
		stagePosition = value;
		onStagePositionChanged();
		return stagePosition;
	}

	function set_showStageBorder(value:Bool):Bool
	{
		showStageBorder = value;
		updateStageBorder();
		return showStageBorder;
	}

	function updateStageBorder()
	{
		if (showStageBorder)
		{
			stageBorder.clear();
			stageBorder.lineStyle(1, 0xFFFFFF);
			stageBorder.drawRect(0, 0, width, height);
		}
	}

	function get_width():Float
	{
		return stageScaleMode == StageScaleMode.NO_SCALE ? engine.width : defaultWidth;
	}

	function get_height():Float
	{
		return stageScaleMode == StageScaleMode.NO_SCALE ? engine.height : defaultHeight;
	}

	function get_mouseX():Float
	{
		return (s2d.mouseX - x) / scaleX;
	}

	function get_mouseY():Float
	{
		return (s2d.mouseY - y) / scaleY;
	}

	public function onResize():Void
	{
		updateStageBorder();
	}
}

enum StageScaleMode {
	NO_SCALE;
	SHOW_ALL;
	EXACT_FIT;
}

enum StagePosition {
	LEFT_TOP;
	LEFT_MIDDLE;
	LEFT_BOTTOM;
	CENTER_TOP;
	CENTER_MIDDLE;
	CENTER_BOTTOM;
	RIGHT_TOP;
	RIGHT_MIDDLE;
	RIGHT_BOTTOM;
}