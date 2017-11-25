package hpp.heaps;

import h2d.Layers;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dSubState
{
	public var container(default, null):Layers;
	
	public function new()
	{
		container = new Layers();
		build();
	}
	
	function build() {}
	public function onOpen() {}
	public function onClose() {}
	public function update(float:Float) {}
	public function dispose() {}
	public function onFocus() {}
	public function onFocusLost() {}
	public function onStageScale(ratioX:Float, ratioY:Float) {}
}