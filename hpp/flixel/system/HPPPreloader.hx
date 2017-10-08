package hpp.flixel.system;

import flash.display.Bitmap;
import flixel.system.FlxBasePreloader;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;

@:bitmap("assets/images/fpp_logo.png") class FppLogo extends BitmapData { }
@:bitmap("assets/images/preloading_fpp_logo.png") class PreloadingFppLogo extends BitmapData { }

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPPreloader extends FlxBasePreloader
{
	var container:Sprite;
	
	var logo:Bitmap;
	var logoBack:Bitmap;
	
	var logoMask:Sprite;
	
	var lastSavedTime:Float = 0;
	
	public function new(minDisplayTime:Float=2, ?allowedURLs:Array<String>)
	{
		super(minDisplayTime, allowedURLs);
	}
	
	override function create():Void 
	{
		_width = Lib.current.stage.stageWidth;
		_height = Lib.current.stage.stageHeight;
		
		addChild( container = new Sprite() );
		
		container.addChild( logoBack = new Bitmap( new PreloadingFppLogo(0, 0) ) );
		container.addChild( logo = new Bitmap( new FppLogo(0, 0) ) );
		
		container.addChild( logoMask = new Sprite() );
		logoMask.graphics.beginFill( 0xFFFFFF, 1 );
		logoMask.graphics.drawRect( logo.x, logo.y, 188, 47 );
		logoMask.graphics.endFill();
		logoMask.scaleX = 0;
		
		logo.mask = logoMask;
		
		container.x = _width / 2 - 222 / 2;
		container.y = _height / 2 - 60 / 2;
		
		super.create();
	}
	 
	override function update(Percent:Float):Void 
	{
		logoMask.scaleX = Percent;
		if (Percent == 1 && lastSavedTime == 0) lastSavedTime = Date.now().getTime();
		
		super.update(Percent);
	}
	
	override public function onLoaded() 
	{
		super.onLoaded();
		_loaded = false;
		
		addEventListener(Event.ENTER_FRAME, onEnterFrameAfterLoaded);
	}
	
	function onEnterFrameAfterLoaded(e:Event):Void
	{
		if (logoMask.scaleX == 1)
		{
			var now:Float = Date.now().getTime();
			var elpasedTime:Float = now - lastSavedTime;

			container.alpha -= elpasedTime * .002;
			if (container.alpha <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrameAfterLoaded);
				_loaded = true;
			}
			
			lastSavedTime = now;
		}
	}
}