package hpp.flixel.ui;

import flixel.FlxG;
import flixel.addons.ui.FlxUIButton;
import flixel.input.IFlxInput;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPButton extends FlxUIButton
{
	public static inline var CLICK_MAX_TIME:Float = 1000;
	public static inline var MOUSE_CLICK_RECT_OFFSET:Float = 15;

	public var overScale:Float = 1;
	public var labelSize(default, set):Int = 8;

	public var onMouseOver:Void->Void;
	public var onMouseOut:Void->Void;

	var realOnClick:HPPButton->Void;
	var mouseDownTime:Float;
	var mouseDownRect:FlxRect;
	var cameraRect:FlxRect;
	var baseGraphic:String;
	var overGraphic:String;

	public function new(label:String = "", onClick:HPPButton->Void = null, baseGraphic:String = null, overGraphic:String = null)
	{
		super(0, 0, label, null, false, true);

		this.baseGraphic = baseGraphic;
		this.overGraphic = overGraphic;

		realOnClick = onClick;
		mouseDownRect = new FlxRect();
		cameraRect = new FlxRect();
		moves = false;
		labelOffsets[2].y = 0;

		if (baseGraphic != null)
		{
			loadGraphic(HPPAssetManager.getGraphic(baseGraphic));
		}
	}

	override function updateStatus(input:IFlxInput):Void
	{
		super.updateStatus(input);

		if (input.justPressed)
		{
			mouseDownTime = Date.now().getTime();
			mouseDownRect.set(	FlxG.stage.mouseX - MOUSE_CLICK_RECT_OFFSET / 2,
								FlxG.stage.mouseY - MOUSE_CLICK_RECT_OFFSET / 2,
								MOUSE_CLICK_RECT_OFFSET,
								MOUSE_CLICK_RECT_OFFSET);
		}
	}
	override function onUpHandler():Void
	{
		super.onUpHandler();

		cameraRect.set(camera.x, camera.y, camera.width, camera.height);
		var mousePoint:FlxPoint = new FlxPoint(FlxG.stage.mouseX, FlxG.stage.mouseY);

		if (isMouseInteractionEnabled()
			&& Date.now().getTime() - mouseDownTime < CLICK_MAX_TIME
			&& mouseDownRect.containsPoint(mousePoint)
			&& cameraRect.containsPoint(mousePoint)
		) {
			realOnClick(this);
		}

		onOutHandler();
	}

	function isMouseInteractionEnabled():Bool
	{
		return visible && exists && active && realOnClick != null && getHitbox().containsPoint(new FlxPoint(FlxG.stage.mouseX, FlxG.stage.mouseY));
	}

	override private function onOverHandler():Void
	{
		if (overScale != 1) scale.set(overScale, overScale);
		if (overGraphic != null) loadGraphic(HPPAssetManager.getGraphic(overGraphic));
		if (label != null) label.scale.set(overScale, overScale);
		if (onMouseOver != null) onMouseOver();

		super.onOverHandler();
	}

	override private function onOutHandler():Void
	{
		if (overScale != 1) scale.set(1, 1);
		if (baseGraphic != null && overGraphic != null) loadGraphic(HPPAssetManager.getGraphic(baseGraphic));
		if (label != null) label.scale.set(1, 1);
		if (onMouseOut != null)onMouseOut();

		super.onOutHandler();
	}

	// Fix for: When you change the size on the label sometimes it doesn't update the text position
	public function set_labelSize(value:Int):Int
	{
		label.size = value;
		autoCenterLabel();

		return labelSize = value;
	}

	override public function graphicLoaded():Void
	{
		super.graphicLoaded();

		if (label != null)
		{
			label.fieldWidth = width;
			autoCenterLabel();
		}
	}
}