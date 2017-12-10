package hpp.openfl.ui;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Krisztian Somoracz
 */
class BaseButton extends Sprite
{
	public var label(default, null):TextField;
	public var labelText(get, set):String;
	public var font(get, set):String;
	public var fontSize(get, set):UInt;
	public var isEnabled(default, set):Bool = true;
	public var isSelected(default, set):Bool;
	public var isSelectable(default, set):Bool;
	public var onSelected(null, set):BaseButton->Void;
	
	public var onClick:BaseButton->Void;
	
	var onSelectedCallbacks:Array<BaseButton->Void> = [];
	
	var baseGraphic:DisplayObject;
	var overGraphic:DisplayObject;
	var selectedGraphic:DisplayObject;
	
	public function new(
		onClick:BaseButton->Void = null,
		text:String = "",
		baseGraphic:DisplayObject = null,
		overGraphic:DisplayObject = null,
		selectedGraphic:DisplayObject = null,
		font:String = "Verdana"
	)
	{
		super();
		
		this.onClick = onClick;
		this.baseGraphic = baseGraphic == null ? new PlaceHolder(175, 50, 0x404040, 1) : baseGraphic;
		this.overGraphic = overGraphic == null ? baseGraphic == null ? baseGraphic : new PlaceHolder(175, 50, 0x606060, 1) : overGraphic;
		this.selectedGraphic = selectedGraphic == null ? baseGraphic == null ? baseGraphic : new PlaceHolder(175, 50, 0xFFFFFF, 1) : selectedGraphic;
		
		label = new TextField();
		if (text != "") addChild(label);
			
		label.defaultTextFormat = new TextFormat(font, 15, 0x000000, null, null, null, null, null, TextFormatAlign.CENTER);
		label.autoSize = "center";
		label.text = text;

		updateView();
		onOutHandler(null);
		
		addEventListener(MouseEvent.MOUSE_OVER, onOverHandler);
		addEventListener(MouseEvent.MOUSE_OUT, onOutHandler);
		addEventListener(MouseEvent.CLICK, onClickHandler);
		
		mouseChildren = false;
		buttonMode = true;
	}
	
	function onOverHandler(_) 
	{
		addChildAt(overGraphic, 0);
		removeChild(selectedGraphic);
		removeChild(baseGraphic);
	}
	
	function onOutHandler(_) 
	{
		if (isSelectable && isSelected)
		{
			addChildAt(selectedGraphic, 0);
			removeChild(baseGraphic);
		}
		else
		{
			addChildAt(baseGraphic, 0);
			removeChild(selectedGraphic);
		}
		
		removeChild(overGraphic);
	}
	
	public function onClickHandler(_):Void
	{
		if (isSelectable) toggle();
		
		onOutHandler(_);
		
		if (onClick != null)
		{
			onClick(this);
		}
	}
	
	function get_labelText():String 
	{
		return label.text;
	}
	
	function set_labelText(value:String):String 
	{
		if (value != "" && label.parent == null) addChild(label);
		if (value == "" && label.parent != null) removeChild(label);
		
		return label.text = value;
	}
	
	public function get_font():String
	{
		return label.defaultTextFormat.font;
	}
	
	public function set_font(font:String):String
	{
		var textFormat:TextFormat = label.defaultTextFormat;
		textFormat.font = font;
		label.defaultTextFormat = textFormat;
		
		updateView();
		
		return font;
	}
	
	function get_fontSize():UInt
	{
		return label.defaultTextFormat.size;
	}
	
	function set_fontSize(value:UInt):UInt 
	{
		var textFormat:TextFormat = label.defaultTextFormat;
		textFormat.size = value;
		label.defaultTextFormat = textFormat;
		
		updateView();
		
		return value;
	}
	
	public function toggle():Void
	{
		isSelected = !isSelected;
	}
	
	function set_isSelectable(value:Bool):Bool 
	{
		isSelectable = value;
		
		onOutHandler(null);
		
		return value;
	}
	
	function set_isSelected(value:Bool):Bool 
	{
		isSelected = value;
		
		if (isSelected)
		{
			for (callback in onSelectedCallbacks)
			{
				callback(this);
			}
		}
		
		onOutHandler(null);
		
		return value;
	}
	
	function updateView():Void
	{
		label.x = baseGraphic.width / 2 - label.width / 2;
		label.y = baseGraphic.height / 2 - label.height / 2;
	}
	
	function set_onSelected(value:BaseButton->Void):BaseButton->Void 
	{
		onSelectedCallbacks.push(value);
		
		return value;
	}
	
	function set_isEnabled(value:Bool):Bool 
	{
		isEnabled = value;
		
		this.mouseEnabled = isEnabled;
		
		return isEnabled;
	}
}