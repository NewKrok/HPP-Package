package hpp.flixel.ui;

import flixel.system.FlxAssets.FlxGraphicAsset;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.input.IFlxInput;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPButton extends FlxUIButton
{
	public static inline var CLICK_MAX_TIME:Float = 1000;
	public static inline var MOUSE_CLICK_RECT_OFFSET:Float = 10;
	
	public var overScale:Float = 1;
	public var labelSize( default, set ):Int = 8;
	
	var realOnClick:Void->Void;
	var mouseDownTime:Float;
	var mouseDownRect:FlxRect;
	
	public function new( label:String, onClick:Void->Void = null )
	{
		super( 0, 0, label, null );
		
		realOnClick = onClick;
		mouseDownRect = new FlxRect();
	}
	
	override function updateStatus( input:IFlxInput ):Void
	{
		super.updateStatus( input );
		
		if (input.justPressed)
		{
			mouseDownTime = Date.now().getTime();
			mouseDownRect.set( 	FlxG.stage.mouseX - MOUSE_CLICK_RECT_OFFSET,
								FlxG.stage.mouseY - MOUSE_CLICK_RECT_OFFSET,
								FlxG.stage.mouseX + MOUSE_CLICK_RECT_OFFSET,
								FlxG.stage.mouseX + MOUSE_CLICK_RECT_OFFSET );
		}
	}
	override function onUpHandler():Void 
	{
		super.onUpHandler();
		
		if ( isMouseInteractionEnabled()
			&& Date.now().getTime() - mouseDownTime < CLICK_MAX_TIME
			&& mouseDownRect.containsPoint( new FlxPoint( FlxG.stage.mouseX, FlxG.stage.mouseY ) ) )
		{
			realOnClick();
		}
	}
	
	function isMouseInteractionEnabled():Bool
	{
		return visible && exists && active && realOnClick != null && getHitbox().containsPoint( new FlxPoint( FlxG.stage.mouseX, FlxG.stage.mouseY ) );
	}
	
	override private function onOverHandler():Void
	{
		super.onOverHandler();
		
		scale.set( overScale, overScale );
		
		if ( label != null )
		{
			label.scale.set( overScale, overScale );
		}
	}
	
	override private function onOutHandler():Void
	{
		super.onOutHandler();
		
		scale.set( 1, 1 );
		
		if ( label != null )
		{
			label.scale.set( 1, 1 );
		}
	}
	
	public function set_labelSize( value:Int ):Int 
	{
		label.size = value;
		autoCenterLabel();
		
		return labelSize = value;
	}
	
	override public function graphicLoaded():Void 
	{
		super.graphicLoaded();
		
		if ( label != null )
		{
			label.fieldWidth = width;
			autoCenterLabel();
		}
	}
}