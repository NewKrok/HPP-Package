package hpp.openfl.debug;

import hpp.util.TimeUtil;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Krisztian Somoracz
 */
class DebugConsole extends Sprite
{
	static var instance:DebugConsole;
	static var text:TextField;
	static var lastSavedVisibility:Bool;
	static var isInited:Bool = false;
	static var queue:Array<String> = [];
	
	public function new() 
	{
		super();
		
		if (instance == null)
		{
			add("Debug console view created");
			
			addEventListener(Event.ADDED_TO_STAGE, inited);
			instance = this;
		}
		else
		{
			add("DebugConsole instance already created!", true);
		}
	}
	
	public function inited(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, inited);
		
		graphics.beginFill(0, .6);
		graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		graphics.endFill();
		
		var margin:Int = 10;
		
		text = new TextField();
		text.selectable = false;
		text.width = stage.stageWidth - margin * 2;
		text.height = stage.stageHeight - margin * 2;
		text.x = margin;
		text.y = margin;
		text.defaultTextFormat = new TextFormat("Courier New", 12, 0xFFFFFF);
		addChild( text );
		
		if (lastSavedVisibility)
		{
			show();
		}
		else
		{
			hide();
		}
		
		isInited = true;
		
		for (entry in queue)
		{
			addFormattedEntry( entry );
		}
	}
	
	public static function show():Void
	{
		lastSavedVisibility = true;
		if (instance != null)
		{
			instance.visible = true;
			instance.addEventListener(MouseEvent.CLICK, onClick);
		}
	}
	
	public static function hide():Void
	{
		lastSavedVisibility = false;
		if (instance != null)
		{
			instance.visible = false;
			instance.removeEventListener(MouseEvent.CLICK, onClick);
		}
	}
	
	static private function onClick(e:MouseEvent):Void 
	{
		hide();
	}
	
	public static function add(entry:String, showAutomatically:Bool = false):Void
	{
		var formattedEntry:String = "[" + TimeUtil.timeStampToFormattedTime(Date.now().getTime(), TimeUtil.TIME_FORMAT_HH_MM_SS_MS) + "] " + entry;
		
		if (isInited)
		{
			addFormattedEntry( formattedEntry );
		}
		else
		{
			queue.push( formattedEntry );
		}
		
		if (showAutomatically) show();
	}
	
	static function addFormattedEntry(entry:String):Void
	{
		if (isInited)
		{
			text.text = entry + "\n" + text.text;
		}
		else
		{
			queue.push( entry );
		}
	}
}