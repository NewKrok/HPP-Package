package hppdemo.view;

import hpp.flixel.ui.HPPButton;
import hpp.flixel.util.HPPAssetManager;
import hppdemo.Fonts;

/**
 * ...
 * @author Krisztian Somoracz
 */
class MenuButton extends HPPButton
{
	public function new( labelText:String, onClick:HPPButton->Void = null ) 
	{
		super( labelText, onClick, "menu_button" );
		
		overScale = .95;
		labelSize = 25;
		label.font = Fonts.DEFAULT_FONT;
	}
}