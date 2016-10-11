package testGame;

import kge.core.Basic;
import kge.core.Game;
import kge.math.MathUtils;
import kha.Color;
import kha.Framebuffer;
import kge.math.VectorUtils;
import kha.Image;
import kha.graphics2.GraphicsExtension;
import kha.math.Vector2;

class TrackEditor extends Basic
{
	
	private var track:TrainTrack;
	private var selectedPoint:Vector2;
	private var selectedIndex:Int;
	
	private var selectedIntersection:Vector2;
	
	private var endPoint:Vector2;	

	public function new(track:TrainTrack) 
	{
		super(0, 0);
		
		this.track = track;
	}
	
	override public function update() 
	{
		super.update();
		
		if (Game.input.mouse.buttonUp(0) && selectedPoint != null) {
			track.moveTrackPoint(selectedIndex, endPoint);
			
			selectedPoint = null;
			selectedIndex = -1;
			endPoint = null;
		}
		
		var mousePos:Vector2 = Game.input.mouse.mousePosition;
		var point:Vector2;
		var nextPoint:Vector2;
		
		//Edit track point
		for (i in 0...track.trackPoints.length) {
			point = track.getPoint(i);
			if (VectorUtils.distance(point, mousePos) < 10) {
				if (Game.input.mouse.buttonPressed(0)) {
					selectedPoint = point;
					selectedIndex = i;
					endPoint = new Vector2(0, 0);
					break;
				}
			}
		}
		
		//Add new point
		selectedIntersection = null;
		if(selectedPoint == null) {
			for (i in 0...track.trackPoints.length) {
				point = track.getPoint(i);
				nextPoint = track.getPoint(i + 1);
				if (MathUtils.circleLineCol(mousePos, 5, point, nextPoint)) {
					selectedIntersection = mousePos;
					if (Game.input.mouse.buttonPressed(0)) {
						track.addTrackPoint(mousePos, i + 1);
					}
					break;
				}
			}
		}
		
		if (Game.input.mouse.buttonDown(0) && selectedPoint != null) {
			endPoint.x = mousePos.x;
			endPoint.y = mousePos.y;
		}
	}
	
	override public function render(framebuffer:Image) 
	{
		super.render(framebuffer);
		
		if (selectedPoint != null) {
			framebuffer.g2.color = Color.White;
			GraphicsExtension.drawCircle(framebuffer.g2, selectedPoint.x, selectedPoint.y, 10, 2, 10);
		}
		
		if (selectedIntersection != null) {
			framebuffer.g2.color = Color.White;
			GraphicsExtension.drawCircle(framebuffer.g2, selectedIntersection.x, selectedIntersection.y, 10, 2, 10);
		}
		
		if (endPoint != null) {
			framebuffer.g2.color = Color.Green;
			GraphicsExtension.fillCircle(framebuffer.g2, endPoint.x, endPoint.y, 5, 10);
			var v1:Vector2 = track.getPoint(selectedIndex - 1);
			var v2:Vector2 = track.getPoint(selectedIndex + 1);
			framebuffer.g2.drawLine(endPoint.x, endPoint.y, v1.x, v1.y);
			framebuffer.g2.drawLine(endPoint.x, endPoint.y, v2.x, v2.y);
		}
	}
	
}