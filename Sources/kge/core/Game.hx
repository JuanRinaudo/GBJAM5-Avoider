package kge.core;

import kge.core.State;
import kha.Assets;
import kha.Image;
import kha.Scaler;
import kha.System;
import kha.math.FastMatrix3;
import kha.math.Vector2;

import kha.Scheduler;

import kha.Framebuffer;
import kha.Color;
import kha.graphics2.ImageScaleQuality;
import kha.graphics4.DepthStencilFormat;
import kha.ScreenRotation;

#if js
import js.Browser;
import js.html.Document;
#end

class Game extends Group<Basic>
{
	public static var instance:Game;
	
	public static var width:Int;
	public static var height:Int;
	
	public static var title:String;
	
	public static var initialState:Class<Dynamic>;
	
	public static var time:Float;
	public static var deltaTime:Float = 1 / 60;
	
	public static var paused:Bool = false;
	public static var pauseOnBlur:Bool = true;
	
	public static var input:Input;
	
	public static var audio:AudioManager;
	
	private static var mainLoopID:Int;
	
	private static var screenTransform:FastMatrix3;
	
	private static var backbuffer:Image;
	
	private var lastState:State;
	
	#if debug
	public var debug:Debug;
	#end
	
	public function new(initialState:Class<Dynamic>, width:Int, height:Int, title:String = "Game") {
		super();
		
		name = title;
		
		instance = this;
		
		Game.width = width;
		Game.height = height;
		
		Game.title = title;
		
		Game.initialState = initialState;
		
		Game.time = 0;
		
		Game.screenTransform = FastMatrix3.identity();
		
		System.init({title: title, width: width, height: height}, initLoader);
		
		#if js
		Browser.window.onblur = pause;
		Browser.window.onfocus = resume;
		Browser.document.getElementById("khanvas").onblur = pause;
		Browser.document.getElementById("khanvas").onfocus = resume;
		#end
	}
	
	public static function pause():Void {
		audio.pauseAll();
		
		input.clearInput();
		
		paused = true && pauseOnBlur;
	}
	
	public static function resume():Void {
		audio.resumeAll();
		
		paused = false;
	}
	
	private function initLoader():Void {
		Assets.loadEverything(initGame);
		
		input = new Input();
		audio = new AudioManager();
	}
	
	private function initGame():Void {		
		Game.backbuffer = Image.createRenderTarget(width, height);
		
		System.notifyOnRender(renderPass);
		
		mainLoopID = Scheduler.addTimeTask(update, 0, deltaTime);
		
		lastState = Type.createInstance(initialState, []);
		add(lastState);
		
		#if debug
		debug = new Debug();
		add(debug);
		#end
	}
	
	public function changeState(state:State, destroy:Bool = true) {
		remove(lastState);
		lastState = state;
		addAt(lastState, 0);
	}

	override public function update():Void {
		if(!paused) {
			super.update();
			
			time += deltaTime;
		}
		
		input.update();
		audio.update();
		
		#if debug
		Debug.updateCalls = 0;
		#end
	}
	
	public function renderPass(framebuffer:Framebuffer) {		
		backbuffer.g2.begin();
		
		backbuffer.g2.transformation = FastMatrix3.identity();
		render(backbuffer);
		
		if (paused) {
			backbuffer.g2.color = Color.fromFloats(0, 0, 0, 0.5);
			backbuffer.g2.fillRect(0, 0, width, height);
			
			backbuffer.g2.color = Color.fromFloats(1, 1, 1, 0.5);
			backbuffer.g2.fillTriangle(	width * 0.33, height * 0.33,
										width * 0.33, height * 0.66,
										width * 0.66, height * 0.5);
		}
		
		backbuffer.g2.end();
		
		framebuffer.g2.imageScaleQuality = ImageScaleQuality.Low;
		framebuffer.g2.begin();
		
		framebuffer.g2.transformation = Game.screenTransform;
		framebuffer.g2.drawImage(backbuffer, 0, 0);
		
		framebuffer.g2.end();
	}

	override public function render(framebuffer:Image):Void {
		super.render(backbuffer);
		
		#if debug
		Debug.drawCalls = 0;
		#end
	}
	
	public function setCamera(scaleX:Float, scaleY:Float, offsetX:Float, offsetY:Float)
	{		
		Game.screenTransform._00 = scaleX;
		Game.screenTransform._11 = scaleY;
		
		Game.screenTransform._20 = offsetX;
		Game.screenTransform._21 = offsetY;
	}
	
}