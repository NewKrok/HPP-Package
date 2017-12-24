package hpp.heaps;

import h2d.Layers;
import h2d.Sprite;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dSubState
{
	public var container(default, null):Layers;

	public var stage:Base2dStage;

	public function new()
	{
		container = new Layers();
		build();
	}

	function addChild(child:Sprite) container.addChild(child);
	function addChildAt(child:Sprite, index:Int) container.addChildAt(child, index);
	function removeChild(child:Sprite) container.removeChild(child);

	function build() {}
	public function onOpen() {}
	public function onClose() {}
	public function update(float:Float) {}
	public function dispose() {}
	public function onFocus() {}
	public function onFocusLost() {}
	public function onStageResize(width:Float, height:Float) {}
	public function onStageScale(ratioX:Float, ratioY:Float) {}
}