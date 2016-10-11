package kge.core;
import haxe.Constraints.Function;

class Signal
{
	
	private var listeners:Array<Function>;

	public function new() {
		listeners = [];
	}
	
	public function add(listener:Function) {
		listeners.push(listener);
	}
	
	public function remove(listener:Function) {
		listeners.remove(listener);
	}
	
	public function dispatch(params:Dynamic) {
		for (listener in listeners) {
			listener(params);
		}
	}
	
}