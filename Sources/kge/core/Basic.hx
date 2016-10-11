package kge.core;

import kha.Image;
import kha.math.FastMatrix3;
import kha.math.Vector2;

class Basic extends CoreBase
{
	public var lastX(get, null):Float;
	public var lastY(get, null):Float;
	private var _lastPosition:Vector2;
	public var x(default, set):Float;
	public var y(default, set):Float;
	
	private var transform:FastMatrix3;
	
	public var origin(get, set):Vector2;
	private var _origin:Vector2;
	public var scale(get, set):Vector2;
	private var _scale:Vector2;
	public var angle(default, set):Float;
	
	public var visible:Bool;
	
	private var dirty:Bool;

	public function new(x:Float = 0, y:Float = 0) {
		super();
		
		this.x = x;
		this.y = y;
		
		transform = FastMatrix3.identity();
		
		_origin = new Vector2(0, 0);
		_scale = new Vector2(1, 1);
		angle = 0;
		
		_lastPosition = new Vector2(0, 0);
		
		visible = true;
		exists = true;
	}
	
	override public function update() {
		_lastPosition.x = x;
		_lastPosition.y = y;
		
		super.update();
	}
	
	public function render(framebuffer:Image) {
		if(visible) {
			#if debug
			++Debug.drawCalls;
			#end
			
			if (dirty) {
				setupTransformation();
			}
			
			postRender(framebuffer);
		}
	}
	
	public function postRender(framebuffer:Image) {
		
	}
	
	public function destroy() {
		
	}
	
	private function set_x(value:Float):Float {
		dirty = true;
		return x = value;
	}
	private function set_y(value:Float):Float {
		dirty = true;
		return y = value;
	}
	
	private function get_origin():Vector2 {
		return new Vector2(transform._20, transform._21);
	}	
	private function set_origin(value:Vector2):Vector2 {
		_origin.x = value.x;
		_origin.y = value.y;
		dirty = true;
		return _origin;
	}
	
	private function get_scale():Vector2 {
		return _scale;
	}
	private function set_scale(value:Vector2) {
		_scale.x = value.x;
		_scale.y = value.y;
		dirty = true;
		return value;
	}
	
	private function get_angle():Float {
		return angle;
	}
	private function set_angle(value:Float):Float {
		angle = value;
		dirty = true;
		return angle;
	}
	
	private function get_lastX():Float {
		return _lastPosition.x;
	}
	private function get_lastY():Float {
		return _lastPosition.y;
	}
	
	private function setupTransformation() {
		var cos = Math.cos(angle);
		var sin = Math.sin(angle);
		transform._00 = cos * _scale.x;
		transform._10 = -sin * _scale.x;
		transform._01 = sin * _scale.y;
		transform._11 = cos * _scale.y;
		transform._20 = x * _scale.x;
		transform._21 = y * _scale.y;
	}
	
}