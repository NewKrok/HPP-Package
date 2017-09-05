package hppdemo.view;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author Krisztian Somoracz
 */
class ScrollPage extends FlxSpriteGroup
{
	var baseBack:FlxSprite;
	
	public function new( pageWidth:Int, pageHeight:Int, startContentId:UInt, maxCol:UInt, maxRow:UInt, horizontalScrollElements:Array<ContentBox>, onContentSelect:ContentBox->Void ) 
	{
		super();
		
		add( baseBack = new FlxSprite() );
		baseBack.makeGraphic( pageWidth, pageHeight, FlxColor.TRANSPARENT );
		
		var baseContainer:FlxSpriteGroup = new FlxSpriteGroup();
		add( baseContainer );
		
		var col:UInt = 0;
		var row:UInt = 0;
		var offset:UInt = 5;
		var maxPiece:Int = startContentId + maxCol * maxRow;
		
		for ( i in startContentId...maxPiece )
		{
			var element:ContentBox = new ContentBox( "Content-" + i, onContentSelect );
			element.x = col * element.width + col * offset;
			element.y = row * element.height + row * offset;
			horizontalScrollElements.push( element );
			
			if ( i == 0 )
			{
				element.select();
			}
			
			col++;
			if ( col == maxCol )
			{
				col = 0;
				row++;
			}
			
			baseContainer.add( element );
		}
		
		baseContainer.x = width / 2 - baseContainer.width / 2;
		baseContainer.y = height / 2 - baseContainer.height / 2;
	}
}