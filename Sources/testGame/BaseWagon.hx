package testGame;

import haxe.ds.Vector;
import kge.core.Game;
import kge.core.Graphic;
import kha.Color;
import kha.math.Vector2;

class BaseWagon extends Graphic
{
	private var locomotive:BaseLocomotive;
	
	private var lastPosition:Vector2;
	private var wagonId:Int = 0;

	public function new(locomotive:BaseLocomotive) 
	{
		super(0, 0, 32, 64);
		
		this.locomotive = locomotive;
		locomotive.wagons++;
		
		wagonId = locomotive.wagons;
		
		color = locomotive.color;
		
		origin = new Vector2(16, 32);
		lastPosition = new Vector2(x, y);
	}
	
	override public function update() 
	{
		super.update();
		
		angle = Math.atan2(lastPosition.y - y, lastPosition.x - x) + Math.PI * 0.5;
		lastPosition = new Vector2(x, y);
		
		var point:Vector2 = locomotive.trainTrack.getPosition(locomotive.trainPoint - height * 1.1 * wagonId);
		x = point.x;
		y = point.y;
	}
	
}