package hpp.heaps;

import h2d.Graphics;
import h2d.Layers;
import h2d.Sprite;
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
	public var currentState(default, null):Base2dState;
	public var stageScaleMode(default, set):StageScaleMode = StageScaleMode.NO_SCALE;
	public var stagePosition(default, set):StagePosition = StagePosition.LEFT_TOP;
	public var showStageBorder(default, set):Bool = false;
	
	var stage:Base2dStage;
	var basePlaceHolder:Graphics;
	var stageBorder:Graphics;
	
	override function init() 
	{
		if (s2d == null) trace("Warning, missing s2d!");
		
		basePlaceHolder = new Graphics(s2d);
		stage = new Base2dStage(s2d);
		stageBorder = new Graphics(s2d);
		
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
	
	public function setDefaultAppSize(width:Int, height:Int):Void
	{
		stage.defaultWidth = width;
		stage.defaultHeight = height;
	}
	
	public function changeState(stateClass:Class<Base2dState>):Void
	{
		if (currentState != null) disposeCurrentState();
		
		currentState = Type.createInstance(stateClass, [stage, changeState]);
		currentState.onStageScale(stage.scaleX, stage.scaleY);
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
	
	function set_stageScaleMode(value:StageScaleMode):StageScaleMode 
	{
		stageScaleMode = value;
		
		updateStageScaleMode();
		
		return stageScaleMode;
	}
	
	function updateStageScaleMode() 
	{
		switch (stageScaleMode)
		{
			case StageScaleMode.NO_SCALE:
				stage.setScale(1);
				
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
				stage.scaleX = s2d.width / stage.defaultWidth;
				stage.scaleY = s2d.height / stage.defaultHeight;
				if (currentState != null && currentRatioX != stage.scaleX || currentRatioY != stage.scaleY ) currentState.onStageScale(stage.scaleX, stage.scaleY);
		}
	}
	
	function getWidthRatio():Float
	{
		return engine.width / stage.defaultWidth;
	}
	
	function getHeightRatio():Float
	{
		return engine.height / stage.defaultHeight;
	}
	
	function set_stagePosition(value:StagePosition):StagePosition 
	{
		stagePosition = value;
		updateStagePosition();
		return stagePosition;
	}
	
	function updateStagePosition() 
	{
		switch (stagePosition)
		{
			case StagePosition.LEFT_TOP:
				stage.x = 0;
				stage.y = 0;
				
			case StagePosition.LEFT_MIDDLE:
				stage.x = 0;
				stage.y = engine.height / 2 - stage.height / 2;
				
			case StagePosition.LEFT_BOTTOM:
				stage.x = 0;
				stage.y = engine.height - stage.height;
				
			case StagePosition.CENTER_TOP:
				stage.x = engine.width / 2 - stage.width / 2;
				stage.y = 0;
				
			case StagePosition.CENTER_MIDDLE:
				stage.x = engine.width / 2 - stage.width / 2;
				stage.y = engine.height / 2 - stage.height / 2;
				
			case StagePosition.CENTER_BOTTOM:
				stage.x = engine.width / 2 - stage.width / 2;
				stage.y = engine.height - stage.height;
				
			case StagePosition.RIGHT_TOP:
				stage.x = engine.width - stage.width;
				stage.y = 0;
				
			case StagePosition.RIGHT_MIDDLE:
				stage.x = engine.width - stage.width;
				stage.y = engine.height / 2 - stage.height / 2;
				
			case StagePosition.RIGHT_BOTTOM:
				stage.x = engine.width - stage.width;
				stage.y = engine.height - stage.height;
		}
	}
	
	function set_showStageBorder(value:Bool):Bool 
	{
		showStageBorder = value;
		updateStageBorder();
		return showStageBorder;
	}
	
	override function onResize() 
	{
		super.onResize();
		updatePlaceHolder();
		updateStageScaleMode();
		updateStagePosition();
		updateStageBorder();
	}
	
	function updatePlaceHolder() 
	{
		basePlaceHolder.clear();
		basePlaceHolder.beginFill(engine.backgroundColor);
		basePlaceHolder.drawRect(0, 0, s2d.width, s2d.height);
		basePlaceHolder.endFill();
	}
	
	function updateStageBorder()
	{
		if (showStageBorder)
		{
			stageBorder.clear();
			stageBorder.lineStyle(1, 0xFFFFFF);
			stageBorder.drawRect(stage.x, stage.y, stage.width, stage.height);
		}
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