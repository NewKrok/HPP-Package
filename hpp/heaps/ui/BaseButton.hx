package hpp.heaps.ui;

import h2d.Bitmap;
import h2d.Font;
import h2d.Interactive;
import h2d.Layers;
import h2d.Text;
import h2d.Tile;
import h2d.comp.Button;
import hxd.res.FontBuilder;

/**
 * ...
 * @author Krisztian Somoracz
 */
class BaseButton extends Layers
{
	public var label(default, null):Text;
	public var labelText(get, set):String;
	public var font(get, set):Font;
	public var isSelected(default, set):Bool;
	public var isSelectable(default, set):Bool;
	public var onSelected(null, set):BaseButton->Void;
	
	public var onClick:BaseButton->Void;
	
	var onSelectedCallbacks:Array<BaseButton->Void> = [];
	
	var baseGraphic:Bitmap;
	var overGraphic:Bitmap;
	var selectedGraphic:Bitmap;
	
	public function new(parent = null, onClick:BaseButton->Void = null, text:String = "", baseGraphic:Tile = null, overGraphic:Tile = null, selectedGraphic:Tile = null, font:Font = null)
	{
		super(parent);
		
		this.onClick = onClick;
		this.baseGraphic = new Bitmap(baseGraphic == null ? Tile.fromColor(0x404040, 175, 50) : baseGraphic, this);
		this.baseGraphic.smooth = true;
		this.overGraphic = new Bitmap(overGraphic == null ? baseGraphic == null ? Tile.fromColor(0x606060, 175, 50) : this.baseGraphic.tile.clone() : overGraphic);
		this.overGraphic.smooth = true;
		this.selectedGraphic = new Bitmap(selectedGraphic == null ? baseGraphic == null ? Tile.fromColor(0xFFFFFF, 175, 50, .1) : this.baseGraphic.tile.clone() : selectedGraphic);
		this.selectedGraphic.smooth = true;
		
		label = new Text(FontBuilder.getFont("Arial", 20), this);
		label.text = text;
		label.textAlign = Align.Center;
		label.maxWidth = this.baseGraphic.tile.width;
		updateView();
		
		var interactive:Interactive = new Interactive(this.baseGraphic.tile.width, this.baseGraphic.tile.height, this);
		interactive.cursor = Button;
		interactive.onClick = onClickHandler;
		interactive.onOver = onOverHandler;
		interactive.onOut = onOutHandler;
	}
	
	function onOverHandler(_) 
	{
		addChildAt(overGraphic, -1);
		removeChild(selectedGraphic);
		removeChild(baseGraphic);
	}
	
	function onOutHandler(_) 
	{
		if (isSelectable && isSelected)
		{
			addChildAt(selectedGraphic, -1);
			removeChild(baseGraphic);
		}
		else
		{
			addChildAt(baseGraphic, -1);
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
		return label.text = value;
	}
	
	public function get_font():Font
	{
		return label.font;
	}
	
	public function set_font(font:Font):Font
	{
		label.font = font;
		updateView();
		
		return font;
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
		label.maxWidth = this.baseGraphic.tile.width / label.scaleX;
		label.y = this.baseGraphic.tile.height / 2 - label.textHeight * label.scaleX / 2;
	}
	
	function set_onSelected(value:BaseButton->Void):BaseButton->Void 
	{
		onSelectedCallbacks.push(value);
		
		return value;
	}
}