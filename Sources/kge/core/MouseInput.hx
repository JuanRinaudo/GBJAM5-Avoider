package kge.core;

import kha.input.Mouse;
import kha.math.Vector2;
import de.polygonal.ds.LinkedQueue;

class MouseInput extends CoreBase
{
	private var buttonData:Map<Int, InputState>;
	private var pressedQueue:LinkedQueue<Int>;
	private var releasedQueue:LinkedQueue<Int>;
	
	public var mousePosition(get, null):Vector2;
	public var mousePosDelta(get, null):Vector2;
	
	public var mouseWheel(get, null):Int;

	public function new() 
	{
		super();
		
		Mouse.get().notify(mouseDownListener, mouseUpListener, mouseMoveListener, mouseWheelListener);
		
		mousePosition = new Vector2();
		mousePosDelta = new Vector2();
		
		buttonData = new Map();
		pressedQueue = new LinkedQueue(5);
		releasedQueue = new LinkedQueue(5);
	}
	
	private function mouseDownListener(index:Int, x:Int, y:Int) {
		mousePosition = new Vector2(x, y);
		mousePosDelta = new Vector2(0, 0);
		buttonData.set(index, InputState.PRESSED);
		pressedQueue.enqueue(index);
	}
	
	private function mouseUpListener(index:Int, x:Int, y:Int) {
		mousePosition = new Vector2(x, y);
		mousePosDelta = new Vector2(0, 0);
		buttonData.set(index, InputState.RELEASED);
		releasedQueue.enqueue(index);
	}
	
	private function mouseMoveListener(x:Int, y:Int, dx:Int, dy:Int) {
		mousePosition = new Vector2(x, y);
		mousePosDelta = new Vector2(dx, dy);
	}
	
	private function mouseWheelListener(delta:Int) {
		mouseWheel = delta;
	}
	
	public function buttonDown(buttonValue:Int):Bool {
		var state:InputState = buttonData.get(buttonValue);
		return state == InputState.DOWN || state == InputState.PRESSED;
	}
	
	public function buttonUp(buttonValue:Int):Bool {
		var state:InputState = buttonData.get(buttonValue);
		return state == InputState.UP || state == InputState.RELEASED;
	}
	
	public function buttonPressed(buttonValue:Int):Bool {
		return buttonData.get(buttonValue) == InputState.PRESSED;
	}
	
	public function buttonReleased(buttonValue:Int):Bool {
		return buttonData.get(buttonValue) == InputState.RELEASED;
	}
	
	override public function update() {
		super.update();
		
		checkQueue(releasedQueue, UP);
		checkQueue(pressedQueue, DOWN);
		
		mouseWheel = 0;
	}
	
	private function checkQueue(queue:LinkedQueue<Int>, state:InputState) {
		var key:String;
		while (!queue.isEmpty()) {
			var key = queue.dequeue();
			if (buttonData.exists(key)) {
				buttonData.set(key, state);
			}
		}
	}
	
	public function get_mousePosition():Vector2 {
		return new Vector2(this.mousePosition.x, this.mousePosition.y);
	}
	
	public function get_mousePosDelta():Vector2 {
		return new Vector2(this.mousePosDelta.x, this.mousePosDelta.y);
	}
	
	public function get_mouseWheel():Int {
		return this.mouseWheel;
	}
}