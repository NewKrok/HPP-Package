package hpp.heaps;

import h2d.Layers;
import h2d.Object;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dSubState
{
	public var container(default, null):Object;

	public var stage:Base2dStage;

	public function new()
	{
		container = new Object();
		build();
	}

	function addChild(child:Object) container.addChild(child);
	function addChildAt(child:Object, index:Int) container.addChildAt(child, index);
	function removeChild(child:Object) container.removeChild(child);

	function build():Void {}

	public function onOpen():Void {}
	public function onClose():Void {}
	public function update(float:Float):Void {}
	public function onFocus():Void {}
	public function onFocusLost():Void {}
	public function onStageResize(width:UInt, height:UInt):Void {}
	public function onStageScale(ratioX:Float, ratioY:Float):Void {}

	public function dispose():Void
	{
		if (container != null)
		{
			container.remove();
			container = null;
		}
	}
}
