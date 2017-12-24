package hppdemo.substate;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import hpp.flixel.ui.HPPHUIBox;
import hpp.flixel.ui.HPPPager;
import hpp.flixel.ui.HPPTouchScrollContainer;
import hppdemo.view.ContentBox;
import hppdemo.view.ScrollPage;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoScrollContainer extends BaseSubState
{
	static inline var maxRow:UInt = 3;
	static inline var maxCol:UInt = 3;
	static inline var pageSize:Int = 320;
	
	var scrollDemoContainers:HPPHUIBox;
	
	var scrollHorizontal:HPPTouchScrollContainer;
	var pagerHorizontal:HPPPager;
	var horizontalScrollElements:Array<ContentBox>;
	
	var scrollVertical:HPPTouchScrollContainer;
	var pagerVertical:HPPPager;
	var verticalScrollElements:Array<ContentBox>;
	
	public function new() 
	{
		super();
		
		build();
	}
	
	function build():Void
	{
		setTitle( "You can drag these contents with mouse or with touch." );
		
		scrollDemoContainers = new HPPHUIBox( 100 );
		
		createHorizontalScrollDemo();
		createVerticalScrollDemo();

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
	
	function createHorizontalScrollDemo():Void 
	{
		var horizontalText:FlxText = new FlxText( 0, 0, pageSize, "Horizontal", 20 );
		horizontalText.alignment = "center";
		horizontalText.font = Fonts.DEFAULT_FONT;
		scrollDemoContainers.add( horizontalText );
		
		scrollHorizontal = new HPPTouchScrollContainer( pageSize, pageSize, new HPPTouchScrollContainerConfig( { snapToPages: true } ) );
		scrollHorizontal.x = FlxG.width / 2 - pageSize - 50;
		scrollHorizontal.y = FlxG.height / 2 - pageSize / 2 + 20;
		add( scrollHorizontal );
		horizontalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, horizontalScrollElements, onHorizontalScrollContentSelect );
			page.x = i * pageSize;
			
			scrollHorizontal.add( page );
		}
		
		pagerHorizontal = new HPPPager( scrollHorizontal, "icon_dark", "icon_normal", 10 );
		pagerHorizontal.overScale = .9;
		pagerHorizontal.x = scrollHorizontal.x + scrollHorizontal.pageWidth / 2 - pagerHorizontal.width / 2;
		pagerHorizontal.y = scrollHorizontal.y + scrollHorizontal.pageHeight + 10;
		add( pagerHorizontal );
	}
	
	function createVerticalScrollDemo():Void 
	{
		var verticalText:FlxText = new FlxText( 0, 0, pageSize, "Vertical", 20 );
		verticalText.alignment = "center";
		verticalText.font = Fonts.DEFAULT_FONT;
		scrollDemoContainers.add( verticalText );
		
		scrollVertical = new HPPTouchScrollContainer( pageSize, pageSize, new HPPTouchScrollContainerConfig( { direction: HPPScrollDirection.VERTICAL, snapToPages: true } ) );
		scrollVertical.x = FlxG.width / 2 + 50;
		scrollVertical.y = FlxG.height / 2 - pageSize / 2 + 20;
		add( scrollVertical );
		verticalScrollElements = [];
		for ( i in 0...3 )
		{
			var page = new ScrollPage( pageSize, pageSize, i * maxRow * maxCol, maxCol, maxRow, verticalScrollElements, onHVerticalScrollContentSelect );
			page.y = i * pageSize;
			
			scrollVertical.add( page );
		}
		
		pagerVertical = new HPPPager( scrollVertical, "icon_dark", "icon_normal", 10, HPPPagerDirection.VERTICAL );
		pagerVertical.overScale = .9;
		pagerVertical.x = scrollVertical.x + scrollVertical.pageWidth + 10;
		pagerVertical.y = scrollVertical.y + scrollVertical.pageHeight / 2 - pagerVertical.height / 2;
		add( pagerVertical );
	}
}