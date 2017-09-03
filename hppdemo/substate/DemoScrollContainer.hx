package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import hpp.flixel.ui.HPPTouchScrollContainer;
import hppdemo.view.ContentBox;
import hppdemo.view.ScrollPage;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoScrollContainer extends FlxSubState
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
		var maxRow:UInt = 3;
		var maxCol:UInt = 3;
		var pageSize:Int = 320;
		
		scrollHorizontal = new HPPTouchScrollContainer( pageSize, pageSize, ScrollDirection.HORIZONTAL, true );
		scrollHorizontal.x = FlxG.width / 2 - pageSize - 100;
		scrollHorizontal.y = FlxG.height / 2 - pageSize / 2 + 40;
		add( scrollHorizontal );
		horizontalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, horizontalScrollElements, onHorizontalScrollContentSelect );
			page.x = i * pageSize;
			
			scrollHorizontal.add( page );
		}
		var horizontalText:FlxText = new FlxText( scrollHorizontal.x, scrollHorizontal.y - 40, pageSize, "Horizontal", 20 );
		horizontalText.alignment = "center";
		horizontalText.font = Fonts.DEFAULT_FONT;
		add( horizontalText );
		
		scrollVertical = new HPPTouchScrollContainer( pageSize, pageSize, ScrollDirection.VERTICAL, true );
		scrollVertical.x = FlxG.width / 2 + 100;
		scrollVertical.y = FlxG.height / 2 - pageSize / 2 + 40;
		add( scrollVertical );
		verticalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, verticalScrollElements, onHVerticalScrollContentSelect );
			page.y = i * pageSize;
			
			scrollVertical.add( page );
		}
		var verticalText:FlxText = new FlxText( scrollVertical.x, scrollVertical.y - 40, pageSize, "Vertical", 20 );
		verticalText.alignment = "center";
		verticalText.font = Fonts.DEFAULT_FONT;
		add( verticalText );
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