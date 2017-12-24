package hpp.ui;

/**
 * @author Krisztian Somoracz
 */
interface IPageable 
{
	var currentPage( get, set ):UInt;
	var pageCount( get, never ):UInt;
	
	function onPageChange( callback:Void->Void ):Void;
}