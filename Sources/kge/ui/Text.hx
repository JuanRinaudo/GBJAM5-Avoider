package kge.ui;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kge.core.Graphic;
import kha.Image;

class Text extends Graphic
{
	
	public var text:String = "";
	public var fontSize:Int = 12;

	public function new(x:Float, y:Float, width:Float, height:Float) 
	{
		super(x, y, width, height);
		
		setCustomDrawFunction(drawText);
	}
	
	private function drawText(framebuffer:Image) {
		framebuffer.g2.font = Assets.fonts.KenPixel;
		framebuffer.g2.fontSize = fontSize;
		framebuffer.g2.drawString(text, -_origin.x, -_origin.y);
	}
	
}