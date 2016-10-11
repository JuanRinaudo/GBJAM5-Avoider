package gbjam5;

import kge.core.Game;
import kge.core.Graphic;
import kge.core.State;
import kge.ui.Text;
import kha.Color;
import kha.Framebuffer;
import kha.math.Vector2;

class MainMenu extends State
{

	public function new() 
	{
		super();
		
		var background:Graphic = new Graphic(0, 0, 160, 144);
		background.color = Colors.light0;
		add(background);
		
		var title:Text = addText(41, 0, Colors.dark0, "Avoider");
		title.fontSize = 24;
		
		addText(8, 24, Colors.dark1, "Avoid this color > ");
		
		addText(8, 40, Colors.dark1, "Dont touch the walls");
		
		var darkSquare:Graphic = new Graphic(100, 25, 8, 8);
		darkSquare.color = Colors.dark1;
		add(darkSquare);
		
		addText(8, 124, Colors.dark0, "Press any button to start");
		
		Game.input.keyboad.onKeyDown.add(onKeyDown);
	}
	
	private function addText(x:Float, y:Float, color:Color, string:String) {
		var text = new Text(x, y, Game.width, Game.height);
		text.color = color;
		text.text = string;
		add(text);
		
		return text;
	}
	
	private function onKeyDown(params:Dynamic) {
		Game.input.keyboad.onKeyDown.remove(onKeyDown);
		Game.instance.changeState(new MainState());
	}
	
}