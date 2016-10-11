package kge.core;

import kha.Key;
import kha.input.Keyboard;
import de.polygonal.ds.LinkedQueue;

class KeyboardInput extends CoreBase
{
	private var keyData:Map<String, InputState>;
	private var pressedQueue:LinkedQueue<String>;
	private var releasedQueue:LinkedQueue<String>;
	
	public var onKeyDown:Signal;
	public var onKeyUp:Signal;
	public var onKeyChange:Signal;
	
	public function new() 
	{
		super();
		
		keyData = new Map();
		pressedQueue = new LinkedQueue(20);
		releasedQueue = new LinkedQueue(20);
		
		onKeyDown = new Signal();
		onKeyUp = new Signal();
		onKeyChange = new Signal();
		
		Keyboard.get().notify(keyDownListener, keyUpListener);
	}
	
	private function keyDownListener(key:Key, value:String) {
		var mapKey:String = key.getName() + value;
		
		onKeyDown.dispatch([key, value]);
		
		keyData.set(mapKey, InputState.PRESSED);
		pressedQueue.enqueue(mapKey);
	}
	
	private function keyUpListener(key:Key, value:String) {
		var mapKey:String = key.getName() + value;
		
		onKeyUp.dispatch([key, value]);
		
		keyData.set(mapKey, InputState.RELEASED);
		releasedQueue.enqueue(mapKey);
	}
	
	public function keyDown(keyValue:String, keyType:Key = null, caseSensitive:Bool = false):Bool {
		if (keyType == null) { keyType = Key.CHAR; }
		
		if (!caseSensitive) {
			var stateLow:InputState = keyData.get(keyType + keyValue.toLowerCase());
			var stateUp:InputState = keyData.get(keyType + keyValue.toUpperCase());
			return stateLow == InputState.DOWN || stateLow == InputState.PRESSED
				|| stateUp == InputState.DOWN || stateUp == InputState.PRESSED;			
		} else {
			var state:InputState = keyData.get(keyType + keyValue);
			return state == InputState.DOWN || state == InputState.PRESSED;
		}
	}
	
	public function keyUp(keyValue:String, keyType:Key = null, caseSensitive:Bool = false):Bool {
		if (keyType == null) { keyType = Key.CHAR; }
		
		if (!caseSensitive) {
			var stateLow:InputState = keyData.get(keyType + keyValue.toLowerCase());
			var stateUp:InputState = keyData.get(keyType + keyValue.toUpperCase());
			return stateLow == InputState.UP || stateLow == InputState.RELEASED
				|| stateUp == InputState.UP || stateUp == InputState.RELEASED;			
		} else {
			var state:InputState = keyData.get(keyType + keyValue);
			return state == InputState.UP || state == InputState.RELEASED;
		}
	}
	
	public function keyPressed(keyValue:String, keyType:Key = null, caseSensitive:Bool = false):Bool {
		if (keyType == null) { keyType = Key.CHAR; }
		
		if (!caseSensitive) {
			return keyData.get(keyType + keyValue.toLowerCase()) == InputState.PRESSED
				|| keyData.get(keyType + keyValue.toUpperCase()) == InputState.PRESSED;
		} else {
			return keyData.get(keyType + keyValue) == InputState.PRESSED;
		}
	}
	
	public function keyReleased(keyValue:String, keyType:Key = null, caseSensitive:Bool = false):Bool {
		if (keyType == null) { keyType = Key.CHAR; }		
		
		if (!caseSensitive) {
			return keyData.get(keyType + keyValue.toLowerCase()) == InputState.RELEASED
				|| keyData.get(keyType + keyValue.toUpperCase()) == InputState.RELEASED;
		} else {
			return keyData.get(keyType + keyValue) == InputState.RELEASED;
		}
	}
	
	override public function update() {
		super.update();
		
		checkQueue(releasedQueue, UP);
		checkQueue(pressedQueue, DOWN);
	}
	
	private function checkQueue(queue:LinkedQueue<String>, state:InputState) {
		var key:String;
		while (!queue.isEmpty()) {
			var key = queue.dequeue();
			if (keyData.exists(key)) {
				keyData.set(key, state);
			}
		}
	}
	
	public function clearInput() {
		var keys = keyData.keys();
		for (key in keys) {
			keyData.remove(key);
		}
		
		while (!pressedQueue.isEmpty()) {
			pressedQueue.dequeue();
		}
		while (!releasedQueue.isEmpty()) {
			pressedQueue.dequeue();
		}
	}
	
}