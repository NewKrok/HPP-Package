package hppdemo.substate;

import hpp.flixel.ui.HPPHUIBox;
import hpp.flixel.ui.HPPUIGrid;
import hpp.flixel.ui.HPPVUIBox;
import hpp.flixel.util.HPPAssetManager;

/**
 * ...
 * @author Krisztian Somoracz
 */ 
class DemoLayout extends BaseSubState
{
	public function new() 
	{
		super();
		
		build();
	}
	
	function build():Void
	{	
		setTitle( "Available layouts: Horizontal Box (HPPHUIBox), Vertical Box (HPPVUIBox), Grid (HPPUIGrid)" );
		
		var demoContainer:HPPHUIBox = new HPPHUIBox( 20 );
		
		var horizontalDemo:HPPHUIBox = new HPPHUIBox( 5 );
		horizontalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		horizontalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		horizontalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		demoContainer.add( horizontalDemo );
		
		var verticalDemo:HPPVUIBox = new HPPVUIBox( 5 );
		verticalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		verticalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		verticalDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		demoContainer.add( verticalDemo );
		
		var gridDemo:HPPUIGrid = new HPPUIGrid( 4, 5 );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		gridDemo.add( HPPAssetManager.getSprite( "demo_content_box" ) );
		demoContainer.add( gridDemo );
		
		mainContainer.add( demoContainer );
		
		rePosition();
	}
}