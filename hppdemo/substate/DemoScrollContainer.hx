package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPHUIBox;
import hpp.flixel.ui.HPPTouchScrollContainer;
import hppdemo.view.ContentBox;
import hppdemo.view.ScrollPage;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoScrollContainer extends BaseSubState
{
	var scrollHorizontal:HPPTouchScrollContainer;
	var horizontalScrollElements:Array<ContentBox>;
	
	var scrollVertical:HPPTouchScrollContainer;
	var verticalScrollElements:Array<ContentBox>;
	
	public function new() 
	{
		super();
		
		build();
	}
	
	function build():Void
	{
		setTitle( "You can drag these contents with mouse or with touch." );
		
		var scrollDemoContainers:HPPHUIBox = new HPPHUIBox( 100 );
		
		var maxRow:UInt = 3;
		var maxCol:UInt = 3;
		var pageSize:Int = 320;
		
		var horizontalText:FlxText = new FlxText( 0, 0, pageSize, "Horizontal", 20 );
		horizontalText.alignment = "center";
		horizontalText.font = Fonts.DEFAULT_FONT;
		scrollDemoContainers.add( horizontalText );
		
		scrollHorizontal = new HPPTouchScrollContainer( pageSize, pageSize, new HPPTouchScrollContainerConfig( { snapToPages: true } ) );
		scrollHorizontal.x = FlxG.width / 2 - pageSize - 50;
		scrollHorizontal.y = FlxG.height / 2 - pageSize / 2 + 40;
		add( scrollHorizontal );
		horizontalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, horizontalScrollElements, onHorizontalScrollContentSelect );
			page.x = i * pageSize;
			
			scrollHorizontal.add( page );
		}
		
		var verticalText:FlxText = new FlxText( 0, 0, pageSize, "Vertical", 20 );
		verticalText.alignment = "center";
		verticalText.font = Fonts.DEFAULT_FONT;
		scrollDemoContainers.add( verticalText );
		
		scrollVertical = new HPPTouchScrollContainer( pageSize, pageSize, new HPPTouchScrollContainerConfig( { direction: HPPScrollDirection.VERTICAL, snapToPages: true } ) );
		scrollVertical.x = FlxG.width / 2 + 50;
		scrollVertical.y = FlxG.height / 2 - pageSize / 2 + 40;
		add( scrollVertical );
		verticalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, verticalScrollElements, onHVerticalScrollContentSelect );
			page.y = i * pageSize;
			
			scrollVertical.add( page );
		}

		mainContainer.add( scrollDemoContainers );
		
		// At the moment you can not add a scrollcontainer into the HPP layout, so this placeholder is just a hack
		mainContainer.add( new FlxSprite().makeGraphic( pageSize, pageSize, FlxColor.TRANSPARENT ) );
		
		rePosition();
	}
	
	function onHorizontalScrollContentSelect( content:ContentBox ):Void
	{
		for ( selectedContent in horizontalScrollElements )
		{
			if ( content == selectedContent )
			{
				selectedContent.select();
			}
			else
			{
				selectedContent.deselect();
			}
		}
	}
	
	function onHVerticalScrollContentSelect( content:ContentBox ):Void
	{
		for ( selectedContent in verticalScrollElements )
		{
			if ( content == selectedContent )
			{
				selectedContent.select();
			}
			else
			{
				selectedContent.deselect();
			}
		}
	}
}