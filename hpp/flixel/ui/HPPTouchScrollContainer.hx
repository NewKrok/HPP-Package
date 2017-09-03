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
	public static var MINIMUM_DRAG_PERCENT_TO_CHANGE_PAGE:Float = .25;
	public static var MAX_OVER_DRAG_PERCENT:Float = .2;
	public static var CHANGE_PAGE_MAX_SPEED:Float = .6;
	public static var CHANGE_PAGE_EASING_TYPE:Float->Float = FlxEase.quadOut;
	
	public var pageHeight:Int;
	public var pageWidth:Int;
	
	var direction:ScrollDirection;
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
	
	public function new( pageWidth:Int, pageHeight:Int, direction:ScrollDirection = ScrollDirection.HORIZONTAL, snapToPages:Bool = false ) 
	{
		super();
		
		this.pageWidth = pageWidth;
		this.pageHeight = pageHeight;
		this.direction = direction;
		this.snapToPages = snapToPages;
		
		calculatedMinimumDragPercentToChangePage = ( direction == ScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * MINIMUM_DRAG_PERCENT_TO_CHANGE_PAGE;
		calculatedMaxOverDragPercent = ( direction == ScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * MAX_OVER_DRAG_PERCENT;
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
		super.update( elapsed );
		
		containerRect.set( x, y, pageWidth, pageHeight );
		
		if ( FlxG.mouse.pressed && containerRect.containsPoint( new FlxPoint( FlxG.stage.mouseX, FlxG.stage.mouseY ) ) )
		{
			if ( !isTouchDragActivated )
			{
				touchStartPosition = new FlxPoint( x + FlxG.mouse.getPosition().x, y + FlxG.mouse.getPosition().y );
				containerTouchStartPosition = new FlxPoint( subContainer.x, subContainer.y );
			}
			
			isTouchDragActivated = true;
			
			if ( direction == ScrollDirection.HORIZONTAL )
			{
				subContainer.x = containerTouchStartPosition.x + FlxG.mouse.getPosition().x - touchStartPosition.x;
			}
			else
			{
				subContainer.y = containerTouchStartPosition.y + FlxG.mouse.getPosition().y - touchStartPosition.y;
			}
			
			normalizePosition();
		}
		else if ( isTouchDragActivated && FlxG.mouse.justReleased && snapToPages )
		{
			var dragDistance:Float = containerTouchStartPosition.distanceTo( new FlxPoint( subContainer.x, subContainer.y ) );
			
			if ( direction == ScrollDirection.HORIZONTAL )
			{
				if ( dragDistance > calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.x > subContainer.x && pageIndex < Math.ceil( subContainer.width / pageWidth ) - 1 )
				{
					moveToPage( pageIndex + 1 );
				} else if ( dragDistance >= calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.x < subContainer.x && pageIndex > 0 )
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
				} else if ( dragDistance >= calculatedMinimumDragPercentToChangePage && containerTouchStartPosition.y < subContainer.y && pageIndex > 0 )
				{
					moveToPage( pageIndex - 1 );
				}
				else
				{
					moveToPage( pageIndex );
				}
			}
		}
		else
		{
			isTouchDragActivated = false;
		}
	}
	
	function normalizePosition() 
	{
		if ( direction == ScrollDirection.HORIZONTAL )
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
		if ( direction == ScrollDirection.HORIZONTAL )
		{
			tweenValues = { x: x + pageIndex * -pageWidth };
			speedBasedOnDistance = Math.abs( ( subContainer.x - pageIndex * -pageWidth ) / pageWidth * CHANGE_PAGE_MAX_SPEED );
		}
		else
		{
			tweenValues = { y: y + pageIndex * -pageHeight };
			speedBasedOnDistance = Math.abs( ( subContainer.y - pageIndex * -pageHeight ) / pageHeight * CHANGE_PAGE_MAX_SPEED );
		}
		
		tween = FlxTween.tween( 
			subContainer,
			tweenValues,
			speedBasedOnDistance,
			{ ease: CHANGE_PAGE_EASING_TYPE }
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
abstract ScrollDirection( String ) {
	var HORIZONTAL = "horizontal";
	var VERTICAL = "vertical";
}