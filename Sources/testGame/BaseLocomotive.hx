package testGame;

import kge.core.Game;
import kge.core.Graphic;
import kha.Color;
import kha.math.Vector2;

class BaseLocomotive extends Graphic
{
	public var trainTrack:TrainTrack;
	public var trainPoint:Float = 0;
	
	public var wagons:Int = 0;
	
	private var lastPosition:Vector2;

	public function new(trainTrack:TrainTrack) 
	{
		super(0, 0, 32, 64);
		
		this.trainTrack = trainTrack;
		
		color = Color.fromFloats(Math.random(), Math.random(), Math.random());
		
		origin = new Vector2(16, 32);
		lastPosition = new Vector2(x, y);
	}
	
	override public function update() 
	{
		super.update();
		
		//trace(trainPoint);
		trainPoint += Game.deltaTime * 100;
		if (trainPoint > trainTrack.totalLength) {
			trainPoint -= trainTrack.totalLength;
		}
		
		angle = Math.atan2(lastPosition.y - y, lastPosition.x - x) + Math.PI * 0.5;
		lastPosition = new Vector2(x, y);
		
		var point:Vector2 = trainTrack.getPosition(trainPoint);
		x = point.x;
		y = point.y;
	}
	
}