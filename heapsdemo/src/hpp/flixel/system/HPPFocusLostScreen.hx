package hpp.flixel.system;

import flixel.FlxG;
import flixel.system.ui.FlxFocusLostScreen;
import openfl.display.Graphics;
import openfl.display.GraphicsPathCommand;
import openfl.geom.Point;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPFocusLostScreen extends FlxFocusLostScreen
{
	public function new()
	{
		super();
		
		removeChildAt( 0 );
	}
	
	override public function draw():Void
	{
		var gfx:Graphics = graphics;
		
		var screenWidth:Int = Std.int( FlxG.stage.stageWidth );
		var screenHeight:Int = Std.int( FlxG.stage.stageHeight );
		
		gfx.clear();
		gfx.moveTo(0, 0);
		gfx.beginFill(0, 0.6);
		gfx.drawRect(0, 0, screenWidth, screenHeight);
		gfx.endFill();
		
		var midPoint:Point = new Point(screenWidth / 2, screenHeight / 2);
		var triangleWidth:Float = 150;

		gfx.beginFill(0xFFFFFF, 0.65);
		gfx.drawPath(
			[ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO ],
			[ 
				midPoint.x - triangleWidth / 2, midPoint.y - triangleWidth / 2,
				midPoint.x + triangleWidth / 2, midPoint.y,
				midPoint.x - triangleWidth / 2, midPoint.y + triangleWidth / 2,
				midPoint.x - triangleWidth / 2, midPoint.y - triangleWidth / 2,
			]
		);
		gfx.endFill();
		
		x = -FlxG.scaleMode.offset.x;
		y = -FlxG.scaleMode.offset.y;
	}
}