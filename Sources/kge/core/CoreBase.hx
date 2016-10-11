package kge.core;


class CoreBase
{
	
	public var exists:Bool;
	
	private var name:String = "";

	public function new(name:String = "") {
		
	}
	
	public function update() {
		#if debug
		++Debug.updateCalls;
		#end
	}
	
}