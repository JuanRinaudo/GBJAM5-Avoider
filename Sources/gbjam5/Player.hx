package gbjam5;

import kge.core.Entity;
import kge.core.Game;
import kha.Key;
import kha.math.Vector2;

class Player extends Entity
{

	public function new(x:Float, y:Float, width:Float, height:Float) 
	{
		super(x, y, width, height);
		
		x += width * 0.5;
		y += height * 0.5;
		
		color = Colors.dark0;
	}
	
	override public function update() 
	{
		super.update();
		
		if (Game.input.keyboad.keyDown("d") || Game.input.keyboad.keyDown("", Key.RIGHT)) {
			x += Game.deltaTime * 100;
		} else if (Game.input.keyboad.keyDown("a") || Game.input.keyboad.keyDown("", Key.LEFT)) {
			x -= Game.deltaTime * 100;
		}
		if (Game.input.keyboad.keyDown("w") || Game.input.keyboad.keyDown("", Key.UP)) {
			y -= Game.deltaTime * 100;
		} else if (Game.input.keyboad.keyDown("s") || Game.input.keyboad.keyDown("", Key.DOWN)) {
			y += Game.deltaTime * 100;
		}
	}
	
}