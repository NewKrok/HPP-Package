package hpp.heaps;

import h2d.Graphics;
import h2d.Layers;
import h2d.Sprite;
import hpp.heaps.Base2dStage.StagePosition;
import hpp.heaps.Base2dStage.StageScaleMode;
import hpp.heaps.HppG;
import hxd.App;
import hxd.Stage;

#if js
	import js.Browser;
	import js.html.Element;
#end

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dApp extends App
{
	public var stage(default, null):Base2dStage;
	public var currentState(default, null):Base2dState;

	var basePlaceHolder:Graphics;

	override function init()
	{
		if (s2d == null) trace("Warning, missing s2d!");

		basePlaceHolder = new Graphics(s2d);
		stage = new Base2dStage(s2d, engine, updateStageScaleMode, updateStagePosition);
		HppG.setStage2d(stage);

		#if js
			var canvas:Element = cast Browser.document.getElementById("webgl");
			untyped __js__("window.onfocus = ()=>this.onFocus();");
			untyped __js__("window.onblur = ()=>this.onFocusLost();");
		#end

		onResize();
	}

	public function onFocus():Void
	{
		wantedFPS = 60;
		if (currentState != null) currentState.onFocus();
	}

	public function onFocusLost():Void
	{
		wantedFPS = 0;
		if (currentState != null) currentState.onFocusLost();
	}

	public function setDefaultAppSize(width:UInt, height:UInt):Void
	{
		stage.defaultWidth = width;
		stage.defaultHeight = height;
	}

	public function changeState(stateClass:Class<Base2dState>):Void
	{
		if (currentState != null) disposeCurrentState();

		currentState = Type.createInstance(stateClass, [stage, changeState]);
	}

	function disposeCurrentState()
	{
		currentState.dispose();
		currentState = null;
	}

	override function update(float:Float)
	{
		if (currentState != null) currentState.update(float);
	}

	function updateStageScaleMode()
	{
		switch (stage.stageScaleMode)
		{
			case StageScaleMode.NO_SCALE:
				stage.scaleX = stage.scaleY = 1;

			case StageScaleMode.SHOW_ALL:
				var currentRatio:Float = stage.scaleX;
				var ratio:Float = 1;
				if (stage.defaultWidth > stage.defaultHeight)
				{
					ratio = getWidthRatio();
					if (stage.defaultHeight * ratio > engine.height)
					{
						ratio = getHeightRatio();
					}
				}
				else
				{
					ratio = getHeightRatio();
					if (stage.defaultWidth * ratio > engine.width)
					{
						ratio = getWidthRatio();
					}
				}
				stage.setScale(ratio);

				if (currentState != null && currentRatio != ratio) currentState.onStageScale(ratio, ratio);

			case StageScaleMode.EXACT_FIT:
				var currentRatioX:Float = stage.scaleX;
				var currentRatioY:Float = stage.scaleY;
				stage.scaleX = engine.width / stage.width;
				stage.scaleY = engine.height / stage.height;

				if (currentState != null && currentRatioX != stage.scaleX || currentRatioY != stage.scaleY )
					currentState.onStageScale(stage.scaleX, stage.scaleY);
		}

		if (currentState != null) currentState.onStageResize(stage.width, stage.height);

		updateStagePosition();
	}

	function getWidthRatio():Float
	{
		return engine.width / stage.defaultWidth;
	}

	function getHeightRatio():Float
	{
		return engine.height / stage.defaultHeight;
	}

	function updateStagePosition()
	{
		if (stage.stageScaleMode != StageScaleMode.SHOW_ALL)
		{
			stage.x = 0;
			stage.y = 0;
			return;
		}

		switch (stage.stagePosition)
		{
			case StagePosition.LEFT_TOP:
				stage.x = 0;
				stage.y = 0;

			case StagePosition.LEFT_MIDDLE:
				stage.x = 0;
				stage.y = engine.height / 2 - stage.height * stage.scaleY / 2;

			case StagePosition.LEFT_BOTTOM:
				stage.x = 0;
				stage.y = engine.height - stage.height * stage.scaleY;

			case StagePosition.CENTER_TOP:
				stage.x = engine.width / 2 - stage.width * stage.scaleX / 2;
				stage.y = 0;

			case StagePosition.CENTER_MIDDLE:
				stage.x = engine.width / 2 - stage.width * stage.scaleX / 2;
				stage.y = engine.height / 2 - stage.height * stage.scaleY / 2;

			case StagePosition.CENTER_BOTTOM:
				stage.x = engine.width / 2 - stage.width * stage.scaleX / 2;
				stage.y = engine.height - stage.height * stage.scaleY;

			case StagePosition.RIGHT_TOP:
				stage.x = engine.width - stage.width * stage.scaleX;
				stage.y = 0;

			case StagePosition.RIGHT_MIDDLE:
				stage.x = engine.width - stage.width * stage.scaleX;
				stage.y = engine.height / 2 - stage.height * stage.scaleY / 2;

			case StagePosition.RIGHT_BOTTOM:
				stage.x = engine.width - stage.width * stage.scaleX;
				stage.y = engine.height - stage.height * stage.scaleY;
		}
	}

	override function onResize()
	{
		super.onResize();

		updatePlaceHolder();
		updateStageScaleMode();
		updateStagePosition();

		stage.onResize();
	}

	function updatePlaceHolder()
	{
		basePlaceHolder.clear();
		basePlaceHolder.beginFill(engine.backgroundColor);
		basePlaceHolder.drawRect(0, 0, s2d.width, s2d.height);
		basePlaceHolder.endFill();
	}
}