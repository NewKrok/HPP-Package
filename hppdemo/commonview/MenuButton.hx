package hppdemo.commonview;

import hpp.flixel.ui.HPPButton;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MenuButton extends HPPButton
{
	public function new( labelText:String, onClick:Void->Void = null ) 
	{
		super( labelText, onClick );
		
		overScale = .95;
		labelSize = 25;
		label.font = Fonts.DEFAULT_FONT;
		
		loadGraphic( HPPAssetManager.getGraphic( "menu_button" ) );
	}
}