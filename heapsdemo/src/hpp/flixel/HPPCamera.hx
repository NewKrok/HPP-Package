package hpp.flixel;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxAxes;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPCamera extends FlxCamera
{
	public var speedZoomEnabled:Bool = false;
	public var maxSpeedZoom:Float = 1.2;
	public var minSpeedZoom:Float = 1;
	public var speedZoomRatio:Float = 200;
	
	public var zoomResisted:Array<FlxSprite> = [];
	
	public function resetPosition():Void
	{
		if ( _scrollTarget != null ) _scrollTarget.set();
		if ( _lastTargetPosition != null ) _lastTargetPosition.set();
		if ( scroll != null ) scroll.set();
	}
	
	override public function update( elapsed:Float ):Void 
	{
		if ( speedZoomEnabled && target != null && _lastTargetPosition != null )
		{
			zoom = 1 + ( 1 - Math.min( maxSpeedZoom, minSpeedZoom + _lastTargetPosition.distanceTo( target.getPosition() ) / speedZoomRatio ) );
		}
		
		var oppositeScale:Float = 1 + ( 1 - zoom );
		for ( element in zoomResisted )
		{
			element.scale.set( oppositeScale, oppositeScale );
		}
		
		super.update( elapsed );
	}
	
	public function addZoomResistanceToSprite( target:FlxSprite ):Void
	{
		zoomResisted.push( target );
	}
	
	public function removeZoomResistanceFromSprite( target:FlxSprite ):Void
	{
		zoomResisted.remove( target );
	}
}