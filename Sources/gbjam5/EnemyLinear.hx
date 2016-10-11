package gbjam5;
import kge.core.Game;
import kha.Sound;
import kha.math.Vector2;


class EnemyLinear extends EnemyBase
{

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		
		setMovementDelta();
	}
	
	override public function update() 
	{
		super.update();
		
		
	}
	
	private function setMovementDelta() {
		movementDelta.x = 0;
		movementDelta.y = 0;
		
		if (x <= -width) {
			movementDelta.x = 100;
		} else if (x >= Game.width - width) {
			movementDelta.x = -100;
		}
		
		if (y < height) {
			movementDelta.y = 100;
		} else if (y > Game.height - height) {
			movementDelta.y = -100;
		}
	}
	
	override public function reset(x:Float, y:Float) 
	{
		super.reset(x, y);
		
		setMovementDelta();
	}
	
}