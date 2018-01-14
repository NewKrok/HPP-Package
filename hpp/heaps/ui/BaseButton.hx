package hpp.heaps.ui;

import h2d.Bitmap;
import h2d.Font;
import h2d.Interactive;
import h2d.Layers;
import h2d.Text;
import h2d.Tile;
import hpp.util.GeomUtil.SimplePoint;
import hpp.util.Selector;
import hxd.Cursor;
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
	public var isEnabled(default, set):Bool;
	public var isSelected(default, set):Bool;
	public var isSelectable(default, set):Bool;
	public var onSelected(null, set):BaseButton->Void;
	public var onDeselected(null, set):BaseButton->Void;
	public var textOffset(default, set):SimplePoint;

	public var overAlpha:Float;
	public var selectedAlpha:Float;

	public var onClick:BaseButton->Void;

	var onSelectedCallbacks:Array<BaseButton->Void> = [];
	var onDeselectedCallbacks:Array<BaseButton->Void> = [];

	var baseGraphic:Bitmap;
	var overGraphic:Bitmap;
	var selectedGraphic:Bitmap;
	var disabledGraphic:Bitmap;

	var interactive:Interactive;

	public function new(parent = null, config:BaseButtonConfig = null)
	{
		super(parent);

		onClick = config.onClick;
		baseGraphic = new Bitmap(config.baseGraphic == null ? Tile.fromColor(0x404040, 175, 35) : config.baseGraphic, this);
		baseGraphic.smooth = true;
		overGraphic = new Bitmap(config.overGraphic == null ? config.baseGraphic == null ? Tile.fromColor(0x606060, 175, 35) : baseGraphic.tile.clone() : config.overGraphic);
		overGraphic.smooth = true;
		selectedGraphic = new Bitmap(config.selectedGraphic == null ? config.baseGraphic == null ? Tile.fromColor(0xFFFFFF, 175, 35, .3) : baseGraphic.tile.clone() : config.selectedGraphic);
		selectedGraphic.smooth = true;
		disabledGraphic = new Bitmap(config.disabledGraphic == null ? config.selectedGraphic == null ? Tile.fromColor(0xFFFFFF, 175, 35, .1) : selectedGraphic.tile.clone() : config.disabledGraphic);
		disabledGraphic.smooth = true;

		label = new Text(config.font == null ? FontBuilder.getFont("Verdana", Selector.firstNotNull([config.fontSize, 12])) : config.font, this);
		label.text = Selector.firstNotNull([config.labelText, ""]);
		label.textColor = Selector.firstNotNull([config.textColor, 0xFFFFFF]);
		label.textAlign = Selector.firstNotNull([config.textAlign, Align.Center]);
		label.maxWidth = baseGraphic.tile.width;

		interactive = new Interactive(baseGraphic.tile.width, baseGraphic.tile.height, this);
		interactive.cursor = Cursor.Button;
		interactive.onClick = onClickHandler;
		interactive.onOver = onOverHandler;
		interactive.onOut = onOutHandler;

		textOffset = Selector.firstNotNull([config.textOffset, { x: 0, y: 0 }]);
		isEnabled = Selector.firstNotNull([config.isEnabled, true]);
		isSelectable = Selector.firstNotNull([config.isSelectable, false]);
		isSelected = Selector.firstNotNull([config.isSelected, false]);
		overAlpha = Selector.firstNotNull([config.overAlpha, 1]);
		selectedAlpha = Selector.firstNotNull([config.selectedAlpha, 1]);

		updateView();
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

			for (callback in onDeselectedCallbacks)
			{
				callback(this);
			}
		}

		onOutHandler(null);

		return value;
	}

	function updateView():Void
	{
		if (label != null)
		{
			label.maxWidth = baseGraphic.tile.width / label.scaleX - textOffset.x * 2;
			label.x = textOffset.x;
			label.y = textOffset.y + baseGraphic.tile.height / 2 - label.textHeight * label.scaleY / 2;
		}
	}

	function set_onSelected(value:BaseButton->Void):BaseButton->Void
	{
		onSelectedCallbacks.push(value);

		return value;
	}

	function set_onDeselected(value:BaseButton->Void):BaseButton->Void
	{
		onDeselectedCallbacks.push(value);

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

typedef BaseButtonConfig = {
	var onClick:BaseButton->Void;
	@:optional var labelText:String;
	@:optional var textOffset:SimplePoint;
	@:optional var textAlign:Align;
	@:optional var font:Font;
	@:optional var textColor:Int;
	@:optional var fontSize:Float;
	@:optional var baseGraphic:Tile;
	@:optional var overGraphic:Tile;
	@:optional var selectedGraphic:Tile;
	@:optional var disabledGraphic:Tile;
	@:optional var isSelectable:Bool;
	@:optional var isSelected:Bool;
	@:optional var isEnabled:Bool;
	@:optional var overAlpha:Float;
	@:optional var selectedAlpha:Float;
}