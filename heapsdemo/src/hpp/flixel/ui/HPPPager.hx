package hpp.flixel.ui;

import flixel.group.FlxSpriteGroup;
import hpp.flixel.ui.HPPHUIBox;
import hpp.flixel.ui.HPPToggleButton;
import hpp.flixel.ui.HPPTouchScrollContainer;
import hpp.ui.IPageable;

/**
 * ...
 * @author Krisztian Somoracz
 */
class HPPPager extends FlxSpriteGroup
{
	public var overScale( default, set ):Float = 1;
	
	var pageableContent:IPageable;
	
	var markers:Array<HPPToggleButton>;
	var pagerGraphicIdNormal:String;
	var pagerGraphicIdSelected:String;
	
	var container:HPPUIBox;
	
	public function new( pageableContent:IPageable, pagerGraphicIdNormal:String, pagerGraphicIdSelected:String, gap:Float = 0, direction:HPPPagerDirection = HPPPagerDirection.HORIZONTAL ) 
	{
		this.pageableContent = pageableContent;
		this.pagerGraphicIdSelected = pagerGraphicIdSelected;
		this.pagerGraphicIdNormal = pagerGraphicIdNormal;
		
		pageableContent.onPageChange( updateMarkers );
		
		super( 20 );
		
		if ( direction == HPPPagerDirection.HORIZONTAL )
		{
			add( container = new HPPHUIBox( gap ) );
		}
		else
		{
			add( container = new HPPVUIBox( gap ) );
		}
		
		build();
		markers[pageableContent.currentPage].isSelected = true;
	}
	
	function build():Void
	{
		markers = [];
		
		for ( i in 0...pageableContent.pageCount )
		{
			var marker:HPPToggleButton = new HPPToggleButton( "", "", selectPage, pagerGraphicIdNormal, pagerGraphicIdSelected/*"pager_page", "pager_selected"*/ );
			
			container.add( marker );
			markers.push( marker );
		}
	}
	
	function updateMarkers():Void
	{
		for ( i in 0...markers.length )
		{
			markers[i].isSelected = i == pageableContent.currentPage;
		}
	}
	
	function selectPage( target:HPPToggleButton ):Void
	{
		target.isSelected = true;
		
		for ( i in 0...markers.length )
		{
			if ( markers[i] != target )
			{
				markers[i].isSelected = false;
			}
			else if ( pageableContent.currentPage != i )
			{
				pageableContent.currentPage = i;
			}
		}
	}
	
	function set_overScale(value:Float):Float 
	{
		overScale = value;
		
		for ( i in 0...markers.length )
		{
			markers[i].overScale = overScale;
		}
		
		return overScale;
	}
}

@:enum
abstract HPPPagerDirection( String ) {
	var HORIZONTAL = "horizontal";
	var VERTICAL = "vertical";
}