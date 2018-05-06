package hpp.heaps;

/**
 * ...
 * @author Krisztian Somoracz
 */
class Base2dState
{
	var stage:Base2dStage;

	var activeSubState:Base2dSubState;

	public function new(stage:Base2dStage)
	{
		this.stage = stage;

		build();
	}

	public function openSubState(subState:Base2dSubState):Void
	{
		closeSubState();

		activeSubState = subState;
		stage.addChild(activeSubState.container);
		activeSubState.stage = stage;
		activeSubState.onOpen();

		onSubStateChanged(activeSubState);
		onSubStateOpened();
	}

	public function closeSubState():Void
	{
		if (activeSubState != null)
		{
			activeSubState.onClose();
			stage.removeChild(activeSubState.container);
			activeSubState = null;

			onSubStateChanged(activeSubState);
			onSubStateClosed();
		}
	}

	function build() {}

	public function onSubStateChanged(activeSubState:Base2dSubState):Void {}
	public function onSubStateOpened():Void {}
	public function onSubStateClosed():Void {}

	public function update(float:Float):Void { if (activeSubState != null) activeSubState.update(float); }
	public function dispose():Void { if (activeSubState != null) activeSubState.dispose(); }
	public function onFocus():Void { if (activeSubState != null) activeSubState.onFocus(); }
	public function onFocusLost():Void { if (activeSubState != null) activeSubState.onFocusLost(); }
	public function onStageResize(width:UInt, height:UInt):Void { if (activeSubState != null) activeSubState.onStageResize(width, height); }
	public function onStageScale(ratioX:Float, ratioY:Float):Void { if (activeSubState != null) activeSubState.onStageScale(ratioX, ratioY); }
}