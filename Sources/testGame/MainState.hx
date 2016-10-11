package testGame;

import kge.core.Game;
import kge.core.Graphic;
import kge.core.State;
import kha.math.Vector2;
import testGame.BaseWagon;

import testGame.BaseLocomotive;
import testGame.TrainTrack;
import testGame.TrackEditor;

class MainState extends State
{
	
	private var track:TrainTrack;
	private var train:BaseLocomotive;

	public function new() 
	{
		super();
		
		track = new TrainTrack();
		track.addTrackPoint(new Vector2(100, 100));
		track.addTrackPoint(new Vector2(400, 100));
		track.addTrackPoint(new Vector2(500, 300));
		track.addTrackPoint(new Vector2(500, 500));
		track.addTrackPoint(new Vector2(100, 500));
		add(track);
		
		var trackEditor:TrackEditor = new TrackEditor(track);
		add(trackEditor);
		
		train = new BaseLocomotive(track);
		add(train);
		var wagon:BaseWagon = new BaseWagon(train);
		add(wagon);
		var wagon:BaseWagon = new BaseWagon(train);
		add(wagon);
		var wagon:BaseWagon = new BaseWagon(train);
		add(wagon);
		
		//var trn:BaseTrain;
		//var trk:TrainTrack;
		//var i:Int, j:Int;
		//for (i in 0...100) {
			//trk = new TrainTrack();
			//for (j in 0...10) {
				//trk.addTrackPoint(new Vector2(Math.random() * Game.width, Math.random() * Game.height));
			//}
			//add(trk);
			//
			//trn = new BaseTrain(trk);
			//add(trn);
		//}
	}
	
	override public function update() 
	{		
		super.update();
		
		if (Game.input.keyboad.keyPressed("R") || Game.input.keyboad.keyPressed("r")) {			
			track.addTrackPoint(new Vector2(Math.random() * Game.width, Math.random() * Game.height));
		}
	}
	
}