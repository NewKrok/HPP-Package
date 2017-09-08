package hpp.flixel.ui;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.VarTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPTouchScrollContainer extends FlxSpriteGroup
{
	private static inline var DISABLE_UPDATE_TIME:Float = 100;
	
	private static var activeTouchScroll:HPPTouchScrollContainer;
	
	public var pageHeight:Int;
	public var pageWidth:Int;
	
	var config:HPPTouchScrollContainerConfig;
	
	var direction:HPPScrollDirection;
	var snapToPages:Bool;
	var isTouchDragActivated:Bool;
	var touchStartPosition:FlxPoint;
	var containerTouchStartPosition:FlxPoint;
	var subContainer:FlxSpriteGroup;
	var subContainerCamera:FlxCamera;
	var containerRect:FlxRect;
	
	var tween:VarTween;
	var pageIndex:Int = 0;
	var calculatedMinimumDragPercentToChangePage:Float = 0;
	var calculatedMaxOverDragPercent:Float = 0;
	var scrollStartTime:Float = 0;
	
	public function new( pageWidth:Int, pageHeight:Int, config:HPPTouchScrollContainerConfig = null ) 
	{
		super();

		this.pageWidth = pageWidth;
		this.pageHeight = pageHeight;
		this.config = config == null ? new HPPTouchScrollContainerConfig() : config;
		
		calculatedMinimumDragPercentToChangePage = ( this.config.direction == HPPScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * this.config.minimumDragPercentToChangePage;
		calculatedMaxOverDragPercent = ( this.config.direction == HPPScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * this.config.maxOverDragPercent;
		containerRect = new FlxRect();
		
		build();
	}
	
	function build():Void
	{
		super.add( subContainer = new FlxSpriteGroup() );
		
		subContainerCamera = new FlxCamera( 0, 0, pageWidth, pageHeight, 1 );
		subContainerCamera.focusOn( new FlxPoint( pageWidth / 2, pageHeight / 2 ) );
		
		subContainer.cameras = [subContainerCamera];
		FlxG.cameras.add( subContainerCamera );
	}
	
	override public function add( sprite:FlxSprite ):FlxSprite 
	{
		return subContainer.add( sprite );
	}
	
	override public function update( elapsed:Float ):Void 
	{
		containerRect.set( x, y, pageWidth, pageHeight );
		
		if ( FlxG.mouse.pressed && ( activeTouchScroll == null || activeTouchScroll == this ) )
		{
			if ( containerRect.containsPoint( new FlxPoint( FlxG.stage.mouseX, FlxG.stage.mouseY ) ) )
			{
				if ( !isTouchDragActivated )
				{
					touchStartPosition = new FlxPoint( x + FlxG.mouse.getPosition().x, y + FlxG.mouse.getPosition().y );
					containerTouchStartPosition = new FlxPoint( subContainer.x, subContainer.y );
					scrollStartTime = Date.now().getTime();
				}
				
				isTouchDragActivated = true;
				
				activeTouchScroll = this;
			}
			
			if ( isTouchDragActivated )
			{
				if ( config.direction == HPPScrollDirection.HORIZONTAL )
				{
					subContainer.x = containerTouchStartPosition.x + FlxG.mouse.getPosition().x - touchStartPosition.x;
				}
				else
				{
					subContainer.y = containerTouchStartPosition.y + FlxG.mouse.getPosition().y - touchStartPosition.y;
				}
				
				normalizePosition();
			}
		}
		else if ( isTouchDragActivated && FlxG.mouse.justReleased && config.snapToPages )
		{
			var dragDistance:Float = containerTouchStartPosition.distanceTo( new FlxPoint( subContainer.x, subContainer.y ) );
			
			if ( config.direction == HPPScrollDirection.HORIZONTAL )
			{
				if ( dragDistance > calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.x > subContainer.x && pageIndex < Math.ceil( subContainer.width / pageWidth ) - 1 )
				{
					moveToPage( pageIndex + 1 );
				}
				else if ( dragDistance >= calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.x < subContainer.x && pageIndex > 0 )
				{
					moveToPage( pageIndex - 1 );
				}
				else
				{
					moveToPage( pageIndex );
				}
			}
			else
			{
				if ( dragDistance > calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.y > subContainer.y && pageIndex < Math.ceil( subContainer.height / pageHeight ) - 1 )
				{
					moveToPage( pageIndex + 1 );
				}
				else if ( dragDistance >= calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.y < subContainer.y && pageIndex > 0 )
				{
					moveToPage( pageIndex - 1 );
				}
				else
				{
					moveToPage( pageIndex );
				}
			}
			
			activeTouchScroll = null;
		}
		else
		{
			isTouchDragActivated = false;
		}
		
		if ( Date.now().getTime() - scrollStartTime < DISABLE_UPDATE_TIME )
		{
			super.update( elapsed );
		}
	}
	
	function normalizePosition() 
	{
		if ( config.direction == HPPScrollDirection.HORIZONTAL )
		{
			subContainer.x = Math.min( subContainer.x, calculatedMaxOverDragPercent );
			subContainer.x = Math.max( subContainer.x, -subContainer.width + pageWidth - calculatedMaxOverDragPercent );
			subContainer.x += x;
		}
		else
		{
			subContainer.y = Math.min( subContainer.y, calculatedMaxOverDragPercent );
			subContainer.y = Math.max( subContainer.y, -subContainer.height + pageHeight - calculatedMaxOverDragPercent );
			subContainer.y += y;
		}
	}
	
	function moveToPage( pageIndex:Int ) 
	{
		this.pageIndex = pageIndex;
		
		disposeTween();
		
		var speedBasedOnDistance:Float;
		var tweenValues:Dynamic;
		if ( config.direction == HPPScrollDirection.HORIZONTAL )
		{
			tweenValues = { x: x + pageIndex * -pageWidth };
			speedBasedOnDistance = Math.abs( subContainer.x - ( x + pageIndex * -pageWidth ) ) / pageWidth * config.changePageMaxSpeed;
		}
		else
		{
			tweenValues = { y: y + pageIndex * -pageHeight };
			speedBasedOnDistance = Math.abs( subContainer.y - ( y + pageIndex * -pageHeight ) ) / pageHeight * config.changePageMaxSpeed;
		}
		
		tween = FlxTween.tween( 
			subContainer,
			tweenValues,
			speedBasedOnDistance,
			{ ease: config.changePageEasingType }
		);
	}
	
	function disposeTween():Void
	{
		if ( tween != null )
		{
			tween.cancel();
			tween.destroy();
			tween = null;
		}
	}
	
	override function set_x( value:Float ):Float 
	{
		if ( subContainerCamera != null )
		{
			subContainerCamera.x = value;
			subContainerCamera.focusOn( new FlxPoint( value + pageWidth / 2, y + pageHeight / 2 ) );
		}
		
		return super.set_x( value );
	}
	
	override function set_y( value:Float ):Float 
	{
		if ( subContainerCamera != null )
		{
			subContainerCamera.y = value;
			subContainerCamera.focusOn( new FlxPoint( x + pageWidth / 2, value + pageHeight / 2 ) );
		}
		
		return super.set_y( value );
	}
}

@:enum
abstract HPPScrollDirection( String ) {
	var HORIZONTAL = "horizontal";
	var VERTICAL = "vertical";
}

typedef HPPTouchScrollContainerConfigParams = {
	@:optional var direction:HPPScrollDirection;
	@:optional var minimumDragPercentToChangePage:Float;
	@:optional var maxOverDragPercent:Float;
	@:optional var changePageMaxSpeed:Float;
	@:optional var changePageEasingType:Float->Float;
	@:optional var snapToPages:Bool;
}

class HPPTouchScrollContainerConfig
{
	public var direction:HPPScrollDirection = HPPScrollDirection.HORIZONTAL;
	
	public var minimumDragPercentToChangePage:Float = .2;
	public var maxOverDragPercent:Float = .15;
	public var changePageMaxSpeed:Float = 1;
	public var changePageEasingType:Float->Float = FlxEase.quadOut;
	
	public var snapToPages:Bool = false;
	
	public function new( config:HPPTouchScrollContainerConfigParams = null ) 
	{
		if ( config != null )
		{
			for ( key in Reflect.fields( config ) )
			{
				Reflect.setField( this, key, Reflect.getProperty( config, key ) );
			}
		}
	}
}