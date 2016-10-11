package gbjam5;

import kge.core.Game;
import kge.core.Graphic;
import kge.core.State;
import kge.ui.Text;
import kha.Color;
import kha.Framebuffer;
import kha.math.Vector2;

class EndState extends MainMenu
{

	public function new() 
	{
		super();
		
		addText(8, 60, Colors.dark0, "Last time: " + Math.floor(GameData.lastTime * 100) / 100);
		
		addText(8, 76, Colors.dark0, "Last level: " + GameData.lastLevel);
		
		addText(8, 92, Colors.dark0, "Best time: " + Math.floor(GameData.bestTime * 100) / 100);
		
		addText(8, 108, Colors.dark0, "Best level: " + GameData.bestLevel);
	}
	
}