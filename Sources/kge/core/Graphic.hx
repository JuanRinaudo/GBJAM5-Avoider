package kge.core;

import haxe.Constraints.Function;
import kha.Assets;
import kha.Color;
import kha.Image;
import kha.graphics2.GraphicsExtension;

class Graphic extends Basic
{	
	public var width:Float;
	public var height:Float;
	
	public var color:Color;
	
	private var drawingFunction:Function;

	public function new(x:Float, y:Float, width:Float, height:Float) 
	{
		super(x, y);
		
		this.width = width;
		this.height = height;
		
		color = Color.White;
		
		setRectangle(width, height);
	}
	
	override public function render(framebuffer:Image) 
	{
		super.render(framebuffer);
		
		if(visible) {
			framebuffer.g2.pushTransformation(transform.multmat(framebuffer.g2.transformation));
			
			framebuffer.g2.color = color;
			drawingFunction(framebuffer);
			
			framebuffer.g2.popTransformation();
		}
	}
	
	public function setRectangle(width:Float, height:Float) {
		drawingFunction = drawRectangle.bind(_, width, height);
	}
	
	public function setCircle(radius:Float, segments:Int = 0) {
		drawingFunction = drawCircle.bind(_, radius, segments);
	}
	
	public function setWebGLImage(Image:Image) {
		drawingFunction = drawWebGLImage.bind(_, Image);
	}
	
	public function setCustomDrawFunction(drawingFunction:Function) {
		this.drawingFunction = drawingFunction;
	}
	
	private function drawRectangle(framebuffer:Image, width:Float, height:Float) {
		framebuffer.g2.fillRect(-_origin.x, -_origin.y, width, height);
	}
	
	private function drawCircle(framebuffer:Image, radius:Float, segments:Int = 0) {
		GraphicsExtension.fillCircle(framebuffer.g2, -_origin.x, -_origin.y, radius, segments);
	}
	
	private function drawWebGLImage(framebuffer:Image, Image:Image) {
		framebuffer.g2.drawImage(Image, -_origin.x, -_origin.y);
	}
	
}