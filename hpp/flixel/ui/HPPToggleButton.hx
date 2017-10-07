package hpp.flixel.ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPButton;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPToggleButton extends FlxSpriteGroup
{
	public var isSelected( default, set ):Bool;
	public var font( default, set ):String;
	public var labelSize( default, set ):Int;
	public var overScale( default, set ):Float;
	public var normalLabel( get, null ):FlxText;
	public var selectedLabel( get, null ):FlxText;
	
	var onClick:HPPToggleButton->Void;
	
	var normalStateButton:HPPButton;
	var selectedStateButton:HPPButton;

	public function new( labelNormal:String = "", labelSelected:String = "", onClick:HPPToggleButton->Void = null, graphicIdNormal:String = null, graphicIdSelected:String = null )
	{
		super();
		
		this.onClick = onClick;

		normalStateButton = new HPPButton( labelNormal, baseOnClick, graphicIdNormal );
		selectedStateButton = new HPPButton( labelSelected, baseOnClick, graphicIdSelected == null ? graphicIdNormal : graphicIdSelected );
		
		scrollFactor.set();
		
		isSelected = false;
	}
	
	function baseOnClick( target:HPPButton ):Void
	{
		toggle();
		
		onClick( this );
	}
	
	function set_isSelected( value:Bool ):Bool 
	{
		if ( isSelected != value )
		{
			isSelected = value;
			updateView();
		}
		
		return isSelected;
	}
	
	public function toggle():Bool
	{
		return isSelected = !isSelected;
	}
	
	function updateView():Void
	{
		if ( isSelected )
		{
			add( selectedStateButton );
			selectedStateButton.alpha = alpha;
			remove( normalStateButton );
		}
		else
		{
			add( normalStateButton );
			normalStateButton.alpha = alpha;
			remove( selectedStateButton );
		}
	}
	
	function set_font( value:String ):String 
	{
		normalStateButton.label.font = value;
		selectedStateButton.label.font = value;
		
		return font = value;
	}
	
	function set_labelSize( value:Int ):Int 
	{
		normalStateButton.labelSize = value;
		selectedStateButton.labelSize = value;
		
		return labelSize = value;
	}
	
	function set_overScale( value:Float ):Float 
	{
		normalStateButton.overScale = value;
		selectedStateButton.overScale = value;
		
		return overScale = value;
	}
	
	public function setNormalIcon( iconGraphicId:String, xOffset:Int = 0, yOffset:Int = 0, center:Bool = false ):Void
	{
		normalStateButton.addIcon( 
			HPPAssetManager.getSprite( iconGraphicId ),
			xOffset,
			yOffset,
			center
		);
	}
	
	public function setSelectedIcon( iconGraphicId:String, xOffset:Int = 0, yOffset:Int = 0, center:Bool = false ):Void
	{
		selectedStateButton.addIcon( 
			HPPAssetManager.getSprite( iconGraphicId ),
			xOffset,
			yOffset,
			center
		);
	}
	
	function get_normalLabel():FlxText 
	{
		return normalStateButton.label;
	}
	
	function get_selectedLabel():FlxText 
	{
		return selectedStateButton.label;
	}
}