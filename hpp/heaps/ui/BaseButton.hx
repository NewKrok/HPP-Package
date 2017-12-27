package hpp.heaps.ui;

import h2d.Bitmap;
import h2d.Font;
import h2d.Interactive;
import h2d.Layers;
import h2d.Text;
import h2d.Tile;
import h2d.comp.Button;
import hpp.util.GeomUtil.SimplePoint;
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
	public var isEnabled(default, set):Bool = true;
	public var isSelected(default, set):Bool;
	public var isSelectable(default, set):Bool;
	public var onSelected(null, set):BaseButton->Void;
	public var textOffset(default, set):SimplePoint = { x:0, y:0 };

	public var overAlpha:Float = 1;
	public var selectedAlpha:Float = 1;

	public var onClick:BaseButton->Void;

	var onSelectedCallbacks:Array<BaseButton->Void> = [];

	var baseGraphic:Bitmap;
	var overGraphic:Bitmap;
	var selectedGraphic:Bitmap;
	var disabledGraphic:Bitmap;

	var interactive:Interactive;

	public function new(parent = null, onClick:BaseButton->Void = null, text:String = "", baseGraphic:Tile = null, overGraphic:Tile = null, selectedGraphic:Tile = null, disabledGraphic:Tile = null, font:Font = null)
	{
		super(parent);

		this.onClick = onClick;
		this.baseGraphic = new Bitmap(baseGraphic == null ? Tile.fromColor(0x404040, 175, 50) : baseGraphic, this);
		this.baseGraphic.smooth = true;
		this.overGraphic = new Bitmap(overGraphic == null ? baseGraphic == null ? Tile.fromColor(0x606060, 175, 50) : this.baseGraphic.tile.clone() : overGraphic);
		this.overGraphic.smooth = true;
		this.selectedGraphic = new Bitmap(selectedGraphic == null ? baseGraphic == null ? Tile.fromColor(0xFFFFFF, 175, 50, .3) : this.baseGraphic.tile.clone() : selectedGraphic);
		this.selectedGraphic.smooth = true;
		this.disabledGraphic = new Bitmap(disabledGraphic == null ? selectedGraphic == null ? Tile.fromColor(0xFFFFFF, 175, 50, .1) : this.selectedGraphic.tile.clone() : disabledGraphic);
		this.disabledGraphic.smooth = true;

		label = new Text(font == null ? FontBuilder.getFont("Verdana", 20) : font, this);
		label.text = text;
		label.textAlign = Align.Center;
		label.maxWidth = this.baseGraphic.tile.width;
		updateView();

		interactive = new Interactive(this.baseGraphic.tile.width, this.baseGraphic.tile.height, this);
		interactive.cursor = Button;
		interactive.onClick = onClickHandler;
		interactive.onOver = onOverHandler;
		interactive.onOut = onOutHandler;
	}

	function onOverHandler(_)
	{
		if (!isEnabled) return;

		addChildAt(overGraphic, -1);

		removeChild(selectedGraphic);
		removeChild(baseGraphic);

		overGraphic.alpha = overAlpha;
	}

	function onOutHandler(_)
	{
		overGraphic.alpha = 1;

		if (!isEnabled)
		{
			addChildAt(disabledGraphic, -1);
			removeChild(selectedGraphic);
			removeChild(baseGraphic);
		}
		else if (isSelectable && isSelected)
		{
			addChildAt(selectedGraphic, -1);
			removeChild(baseGraphic);
			removeChild(disabledGraphic);
		}
		else
		{
			addChildAt(baseGraphic, -1);
			removeChild(selectedGraphic);
			removeChild(disabledGraphic);
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
			selectedGraphic.alpha = selectedAlpha;

			for (callback in onSelectedCallbacks)
			{
				callback(this);
			}
		}
		else
		{
			selectedGraphic.alpha = 1;
		}

		onOutHandler(null);

		return value;
	}

	function updateView():Void
	{
		label.maxWidth = baseGraphic.tile.width / label.scaleX - textOffset.x * 2;
		label.x = textOffset.x;
		label.y = textOffset.y + baseGraphic.tile.height / 2 - label.textHeight * label.scaleY / 2;
	}

	function set_onSelected(value:BaseButton->Void):BaseButton->Void
	{
		onSelectedCallbacks.push(value);

		return value;
	}

	function set_textOffset(value:SimplePoint):SimplePoint
	{
		textOffset = value;
		updateView();

		return textOffset;
	}

	function set_isEnabled(value:Bool):Bool
	{
		isEnabled = value;

		interactive.visible = isEnabled;
		updateView();
		onOutHandler(null);

		return isEnabled;
	}
}