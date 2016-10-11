package kge.core;

class Input extends CoreBase
{

	public var keyboad:KeyboardInput;
	public var mouse:MouseInput;
	
	public function new() 
	{
		super();
		
		keyboad = new KeyboardInput();
		mouse = new MouseInput();
	}
	
	override public function update() {
		super.update();
		
		keyboad.update();
		mouse.update();
	}
	
	public function clearInput() {
		keyboad.clearInput();
	}
	
}