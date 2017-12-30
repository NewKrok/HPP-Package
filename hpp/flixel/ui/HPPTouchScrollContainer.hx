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
import hpp.ui.IPageable;
import hpp.util.GeomUtil.SimplePoint;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPTouchScrollContainer extends FlxSpriteGroup implements IPageable
{
	private static inline var DISABLE_UPDATE_TIME:Float = 100;

	private static var activeTouchScroll:HPPTouchScrollContainer;

	public var pageHeight:Int;
	public var pageWidth:Int;
	public var currentPage( get, set ):UInt;
	public var pageCount( get, null ):UInt;

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
	var hasRunningAnimation:Bool;
	var cameraOffset:SimplePoint = { x: 0, y: 0 };

	var onPageChangeCallback:Array<Void->Void>;

	public function new( pageWidth:Int, pageHeight:Int, config:HPPTouchScrollContainerConfig = null )
	{
		super();

		this.pageWidth = pageWidth;
		this.pageHeight = pageHeight;
		this.config = config == null ? new HPPTouchScrollContainerConfig() : config;
		onPageChangeCallback = [];

		calculatedMinimumDragPercentToChangePage = ( this.config.direction == HPPScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * this.config.minimumDragPercentToChangePage;
		calculatedMaxOverDragPercent = ( this.config.direction == HPPScrollDirection.HORIZONTAL ? pageWidth : pageHeight ) * this.config.maxOverDragPercent;
		containerRect = new FlxRect();

		build();
	}

	function build():Void
	{
		super.add( subContainer = new FlxSpriteGroup() );
		subContainer.scrollFactor.set();
		subContainer.clipRect = new FlxRect(0, 0, pageWidth, pageHeight);
	}

	public function makeActive():Void
	{
		activeTouchScroll = this;
	}

	override public function add( sprite:FlxSprite ):FlxSprite
	{
		subContainer.add( sprite );

		updateMask();

		return sprite;
	}

	override public function update(elapsed:Float):Void
	{
		if (hasRunningAnimation)
		{
			isTouchDragActivated = false;
			activeTouchScroll = null;
			return;
		}

		containerRect.set(x, y, pageWidth, pageHeight);

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
		else if ( isTouchDragActivated && FlxG.mouse.justReleased )
		{
			var dragDistance:Float = containerTouchStartPosition.distanceTo( new FlxPoint( subContainer.x, subContainer.y ) );

			if ( config.direction == HPPScrollDirection.HORIZONTAL )
			{
				if (containerTouchStartPosition.x > subContainer.x)
				{
					if (config.snapToPages && dragDistance > calculatedMinimumDragPercentToChangePage && pageIndex < pageCount - 1)
						moveToPage(pageIndex + 1);
					else if (subContainer.x < -subContainer.width + pageWidth + cameraOffset.x)
						moveTo({ x: -subContainer.width + pageWidth + cameraOffset.x });
					else if (config.snapToPages)
						moveToPage(pageIndex);
				}
				else if (containerTouchStartPosition.x < subContainer.x)
				{
					if (config.snapToPages && dragDistance >= calculatedMinimumDragPercentToChangePage && pageIndex > 0)
						moveToPage(pageIndex - 1);
					else if (subContainer.x > cameraOffset.x)
						moveTo({ x: cameraOffset.x });
					else if (config.snapToPages)
						moveToPage(pageIndex);
				}
				else if (config.snapToPages)
					moveToPage(pageIndex);
			}
			else
			{
				if (containerTouchStartPosition.y > subContainer.y)
				{
					if (config.snapToPages && dragDistance > calculatedMinimumDragPercentToChangePage && pageIndex < pageCount - 1)
						moveToPage(pageIndex + 1);
					else if (subContainer.y < -subContainer.height + pageHeight + cameraOffset.y)
						moveTo({ y: -subContainer.height + pageHeight + cameraOffset.y });
					else if (config.snapToPages)
						moveToPage(pageIndex);
				}
				else if (containerTouchStartPosition.y < subContainer.y)
				{
					if (config.snapToPages && dragDistance >= calculatedMinimumDragPercentToChangePage && pageIndex > 0)
						moveToPage( pageIndex - 1 );
					else if (subContainer.y > cameraOffset.y)
						moveTo({ y: cameraOffset.y });
					else if (config.snapToPages)
						moveToPage(pageIndex);
				}
				else if (config.snapToPages)
					moveToPage(pageIndex);
			}
			activeTouchScroll = null;
		}
		else
		{
			isTouchDragActivated = false;
			hasRunningAnimation = false;
		}

		if (Date.now().getTime() - scrollStartTime < DISABLE_UPDATE_TIME)
		{
			super.update(elapsed);
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

		updateMask();
	}

	function moveToPage(pageIndex:Int)
	{
		var pageStep:UInt = cast Math.abs(this.pageIndex - pageIndex);
		if (pageStep == 0) pageStep = 1;

		this.pageIndex = pageIndex;
		for (callback in onPageChangeCallback) callback();

		if (config.direction == HPPScrollDirection.HORIZONTAL)
			moveTo({ x: x + pageIndex * -pageWidth }, pageStep);
		else
			moveTo({ y: y + pageIndex * -pageHeight }, pageStep);
	}

	function moveTo(tweenValues:Dynamic, pageStep:UInt = 1)
	{
		disposeTween();

		hasRunningAnimation = true;
		var speedBasedOnDistance:Float;

		if (config.direction == HPPScrollDirection.HORIZONTAL)
			speedBasedOnDistance = Math.abs(subContainer.x - tweenValues.x) / pageWidth * (config.changePageMaxSpeed / pageStep);
		else
			speedBasedOnDistance = Math.abs(subContainer.y - tweenValues.y) / pageHeight * (config.changePageMaxSpeed / pageStep);

		if (speedBasedOnDistance > 0)
		{
			tween = FlxTween.tween(
				subContainer,
				tweenValues,
				speedBasedOnDistance,
				{ ease: config.changePageEasingType, onComplete: animationEnded, onUpdate: onAnimationUpdate }
			);
		}
		else hasRunningAnimation = false;
	}

	function animationEnded( tween:FlxTween ):Void
	{
		hasRunningAnimation = false;
	}

	function onAnimationUpdate( tween:FlxTween ):Void
	{
		updateMask();
	}

	function disposeTween():Void
	{
		if ( tween != null )
		{
			tween.cancel();
			tween.destroy();
			tween = null;
		}

		hasRunningAnimation = false;
	}

	function updateMask()
	{
		if (subContainer != null)
		{
			subContainer.clipRect.x = -subContainer.x + cameraOffset.x;
			subContainer.clipRect.y = -subContainer.y + cameraOffset.y;
			subContainer.clipRect = subContainer.clipRect;
		}
	}

	function get_currentPage():UInt
	{
		return pageIndex;
	}

	function set_currentPage( value:UInt ):UInt
	{
		var tempPageIndex = value >= pageCount ? pageCount - 1 : value;

		if ( tempPageIndex != pageIndex )
		{
			moveToPage( tempPageIndex );
		}

		return pageIndex;
	}

	function get_pageCount():UInt
	{
		if ( config.direction == HPPScrollDirection.HORIZONTAL )
		{
			return Math.ceil( subContainer.width / pageWidth );
		}
		else
		{
			return Math.ceil( subContainer.height / pageHeight );
		}
	}

	public function onPageChange( callback:Void->Void ):Void
	{
		onPageChangeCallback.push( callback );
	}

	override public function destroy():Void
	{
		onPageChangeCallback = null;

		super.destroy();

		if ( activeTouchScroll == this )
		{
			activeTouchScroll = null;
		}
	}

	override function set_x(value:Float):Float
	{
		cameraOffset.x = value;
		super.set_x(value);
		updateMask();

		return value;
	}

	override function set_y(value:Float):Float
	{
		cameraOffset.y = value;
		super.set_y(value);
		updateMask();

		return value;
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