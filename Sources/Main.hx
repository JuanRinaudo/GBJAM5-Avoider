package;

import gbjam5.Colors;
import gbjam5.MainMenu;
import kge.core.Game;
import kha.Color;
import kha.math.Vector2;

#if js
import js.Browser;
#end

class Main {
	private static var game:Game;
	
	public static function main() {
		setPalette(0xE0F8D0, 0x88C070, 0x306850, 0x081820);
		
		//new Game(MainState, 800, 800);
		game = new Game(MainMenu, 160, 144);
		
		setScale(5);
		
		addScaleModifier("x1", 1);
		addScaleModifier("x2", 2);
		addScaleModifier("x3", 3);
		addScaleModifier("x4", 4);
		addScaleModifier("x5", 5);
	}
	
	private static function setPalette(light0:UInt, light1:UInt, dark0:UInt, dark1:UInt) {
		Colors.light0 = Color.fromValue(light0 + 0xFF000000);
		Colors.light1 = Color.fromValue(light1 + 0xFF000000);
		Colors.dark0 = Color.fromValue(dark0 + 0xFF000000);
		Colors.dark1 = Color.fromValue(dark1 + 0xFF000000);
	}
	
	private static function addScaleModifier(id:String, value:Int) {
		#if js
		if (Browser.document.getElementById(id) != null) { Browser.document.getElementById(id).onclick = setScale.bind(value); }
		#end
	}
	
	private static function setScale(value:Int) {
		game.setCamera(value, value, 
			Game.width * (5 - value) * 0.5,
			Game.height * (5 - value) * 0.5);
	}
}