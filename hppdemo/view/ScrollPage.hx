package hppdemo.view;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPUIGrid;

/**
 * ...
 * @author Krisztian Somoracz
 */
class ScrollPage extends FlxSpriteGroup
{
	var baseBack:FlxSprite;
	var grid:HPPUIGrid;
	
	public function new( pageWidth:Int, pageHeight:Int, startContentId:UInt, maxCol:UInt, maxRow:UInt, scrollElements:Array<ContentBox>, onContentSelect:ContentBox->Void ) 
	{
		super();
		
		add( baseBack = new FlxSprite() );
		baseBack.makeGraphic( pageWidth, pageHeight, FlxColor.TRANSPARENT );
		
		add( grid = new HPPUIGrid( maxCol, 5 ) );
		
		var maxPiece:Int = startContentId + maxCol * maxRow;
		
		for ( i in startContentId...maxPiece )
		{
			var element:ContentBox = new ContentBox( "Content #" + i, onContentSelect );
			scrollElements.push( element );
			
			if ( i == 0 )
			{
				element.select();
			}
			
			grid.add( element );
		}
		
		grid.x = width / 2 - grid.width / 2;
		grid.y = height / 2 - grid.height / 2;
	}
}