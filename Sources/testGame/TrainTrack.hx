package testGame;

import kge.core.Game;
import kge.core.Graphic;
import kha.Color;
import kha.Framebuffer;
import kha.graphics2.GraphicsExtension;
import kha.math.Vector2;

class TrainTrack extends Graphic
{

	public var trackPoints:Array<Vector2>;
	public var totalLength:Float;
	
	public function new() 
	{
		super(0, 0, Game.width, Game.height);
		
		trackPoints = [];
		
		totalLength = 0;
		
		setCustomDrawFunction(drawTrainTrack);
	}
	
	public function addTrackPoint(point:Vector2, index:Int = -1) {		
		index = Math.floor(Math.max(index == -1 ? trackPoints.length : index, 0));
		
		var length = trackPoints.length + 1;
		
		if(length > 2) {
			totalLength -= getPoint(index - 1).sub(getPoint(index)).length;
			totalLength += getPoint(index - 1).sub(point).length +
				getPoint(index).sub(point).length;
		} else if (length == 2) {
			totalLength = getPoint(0).sub(point).length * 2;
		} else {
			totalLength = 0;
		}
		
		trace(totalLength);
		trackPoints.insert(index, point);
		//if(trackPoints.length > 3) {
			//totalLength -= lastLength;
			//lastLength = trackPoints[0].sub(trackPoints[trackPoints.length - 1]).length;
			//totalLength += lastLength +
				//trackPoints[trackPoints.length - 1].sub(trackPoints[trackPoints.length - 2]).length;
		//} else if (trackPoints.length == 2) {
			//totalLength = trackPoints[0].sub(trackPoints[1]).length * 2;
		//} else if (trackPoints.length == 3) {
			//lastLength = trackPoints[2].sub(trackPoints[0]).length;
			//totalLength = trackPoints[0].sub(trackPoints[1]).length + 
				//trackPoints[1].sub(trackPoints[2]).length + 
				//lastLength;
		//}
	}
	
	public function moveTrackPoint(index:Int, endPoint:Vector2) {
		var prevPoint:Vector2 = getPoint(index - 1);
		var point:Vector2 = getPoint(index);
		var nextPoint:Vector2 = getPoint(index + 1);
		
		totalLength -= prevPoint.sub(point).length + nextPoint.sub(point).length;
		
		point.x = endPoint.x;
		point.y = endPoint.y;
		
		totalLength += prevPoint.sub(point).length + nextPoint.sub(point).length;
	}
	
	public function getPoint(index:Int):Vector2 {
		return trackPoints[(index + trackPoints.length) % trackPoints.length];
	}
	
	public function getPosition(value:Float):Vector2 {
		if (trackPoints.length > 1) {
			
			while (value < 0) {
				value += totalLength;
			}
			
			var lastPoint:Vector2 = trackPoints[0];
			var point:Vector2 = trackPoints[1];
			var i = trackPoints.length + 1;
			while (value >= point.sub(lastPoint).length) {
				value -= point.sub(lastPoint).length;
				lastPoint = point;
				++i;
				point = trackPoints[i % trackPoints.length];
			}
			
			point = trackPoints[(i - 1) % trackPoints.length];
			var delta:Vector2 = trackPoints[i % trackPoints.length].sub(point);
			point = point.add(delta.mult(value / delta.length));
			return point;
		}
		
		return trackPoints[0];
	}
	
	private function drawTrainTrack(framebuffer:Framebuffer) {
		if (trackPoints.length > 1) {
			var lastPoint:Vector2 = trackPoints[0];
			var point:Vector2;
			var i = 1;
			while (i <= trackPoints.length) {
				point = trackPoints[i % trackPoints.length];
				framebuffer.g2.color = Color.White;
				framebuffer.g2.drawLine(lastPoint.x, lastPoint.y, point.x, point.y);
				framebuffer.g2.color = Color.Red;
				GraphicsExtension.fillCircle(framebuffer.g2, lastPoint.x, lastPoint.y, 4, 10);
				lastPoint = point;
				++i;
			}
			GraphicsExtension.fillCircle(framebuffer.g2, lastPoint.x, lastPoint.y, 4, 10);
		}
	}
	
}