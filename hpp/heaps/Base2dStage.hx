package hpp.heaps;

import h2d.Layers;
import h2d.Scene;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dStage extends Layers
{
	public var width(get, never):Float;
	public var height(get, never):Float;
	public var mouseX(get, never):Float;
	public var mouseY(get, never):Float;
	public var defaultWidth:Int = 800;
	public var defaultHeight:Int = 600;

	var s2d:Scene;
	
	public function new(parent:Scene)
	{
		super(parent);
		
		s2d = parent;
	}
	
	function get_width():Float 
	{
		return defaultWidth * scaleX;
	}
	
	function get_height():Float 
	{
		return defaultHeight * scaleY;
	}
	
	function get_mouseX():Float 
	{
		return (s2d.mouseX - x) / scaleX;
	}
	
	function get_mouseY():Float 
	{
		return (s2d.mouseY - y) / scaleY;
	}
}