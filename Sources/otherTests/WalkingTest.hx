package;

import kge.core.Game;
import kge.core.Graphic;
import kge.core.State;
import kha.math.Vector2;
import testGame.MainState;

import testGame.BaseLocomotive;
import testGame.TrainTrack;
import testGame.TrackEditor;

class testGame.MainState extends State
{
	
	private var gs:Array<Graphic>;
	private var input:Float;

	public function new() 
	{
		super();
		
		gs = [];
		var g:Graphic;
		for(i in 0...10) {
			g = new Graphic(10, 10 + 40 * i, 32, 32);
			gs.push(g);
			add(g);
		}
		input = 0;
	}
	
	override public function update() 
	{		
		super.update();
		
		if (Game.input.keyboad.keyDown(" ")) {
			input += Game.deltaTime * 50;
			var g:Graphic;
			gs[0].x += 1;
			gs[1].x += Game.deltaTime * 100;
			gs[2].x += Math.abs(Math.sin(input));
			gs[3].x += Game.deltaTime * 100 * Math.abs(Math.sin(input));
		} else {
			input = 0;
		}
	}
	
}