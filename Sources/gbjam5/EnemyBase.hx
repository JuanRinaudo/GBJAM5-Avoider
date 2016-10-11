package gbjam5;

import kge.core.Entity;
import kge.core.Game;
import kha.Assets;
import kha.Sound;
import kha.audio2.Audio1;
import kha.math.Vector2;

class EnemyBase extends Entity
{
	
	private var movementDelta:Vector2;
	
	public function new(x:Float, y:Float) 
	{
		super(x, y, 8, 8);
		
		movementDelta = new Vector2();
		
		color = Colors.dark1;
	}
	
	override public function update() 
	{
		super.update();
		
		x += movementDelta.x * Game.deltaTime;
		y += movementDelta.y * Game.deltaTime;
	}
	
	public function	reset(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}
	
}