package kge.core;
import kha.Assets;
import kha.Color;
import kha.Image;
import kha.Key;
import kha.System;


class Debug extends Basic
{
	public static var drawCalls:Int = 0;
	public static var updateCalls:Int = 0;
	
	private var lastTime:Float = 0;
	private var fps:Int = 0;

	private var debugActive:Bool = false;
	
	public function new() 
	{
		super();
	}
	
	override public function update() 
	{
		super.update();
		
		fps = Math.floor(1 / (System.time - lastTime));
		lastTime = System.time;
		
		if (Game.input.keyboad.keyDown("", Key.SHIFT) && Game.input.keyboad.keyPressed("D")) {
			debugActive = !debugActive;
		}
	}
	
	override public function render(framebuffer:Image) 
	{
		super.render(framebuffer);
		
		if(debugActive) {
			framebuffer.g2.color = Color.fromFloats(0, 0, 0, 0.5);
			framebuffer.g2.fillRect(0, 0, Game.width, Game.height * 0.5);
			
			framebuffer.g2.color = Color.fromFloats(1, 1, 1, 0.5);
			framebuffer.g2.font = Assets.fonts.KenPixel;
			framebuffer.g2.drawString("Updates: " + updateCalls + " | " + "Draws: " + drawCalls + " | " + fps, 2, 2);
		}
	}
	
}