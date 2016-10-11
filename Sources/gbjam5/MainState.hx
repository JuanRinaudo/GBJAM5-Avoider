package gbjam5;

import kge.core.Entity;
import kge.core.Game;
import kge.core.Graphic;
import kge.core.Group;
import kge.core.State;
import kge.core.Tilemap;
import kge.ui.Text;
import kha.Assets;
import kha.math.Vector2;

import kge.math.CollisionUtils;

class MainState extends State
{
	
	private var player:Player;
	private var tilemap:Tilemap;
	
	private var enemyGroup:Group<EnemyBase>;
	private var enemyManager:EnemyManager;
	
	private var timer:Text;
	private var playTime:Float;
	
	private var gameRunning:Bool;
	
	private var countDown:Text;
	private var countdownTime:Float;
	
	public function new() 
	{
		super();
		
		var background:Graphic = new Graphic(0, 0, 160, 144);
		background.color = Colors.light0;
		add(background);
		
		timer = new Text(16, 16, Game.width, 32);
		timer.color = Colors.dark0;
		add(timer);
		
		enemyGroup = new Group();
		add(enemyGroup);
		
		tilemap = new Tilemap();
		tilemap.setup(generateMap(20, 18), Assets.images.tileset, 8, 8, 1);
		add(tilemap);
		
		player = new Player(Game.width * 0.5, Game.height * 0.5, 8, 8);
		add(player);
		
		countDown = new Text(Game.width * 0.5, Game.height * 0.5, 0, 0);
		countDown.color = Colors.light1;
		countDown.origin = new Vector2(13, 30);
		countDown.fontSize = 60;
		add(countDown);
		
		countdownTime = 3;
	}
	
	override public function update() 
	{
		super.update();
		
		if(gameRunning) {
			timer.text = (Math.floor(enemyManager.playTime * 100) / 100) + "";
			
			enemyManager.update();
		} else {
			countDown.text = Math.ceil(countdownTime) + "";
			countdownTime = Math.max(0, countdownTime - Game.deltaTime);
			if (countdownTime == 0) { startGame(); }
		}
		
		if (CollisionUtils.EntityTilemapOverlaps(player, tilemap)) {
			endGame();
		}
		
		for (enemy in enemyGroup) {
			if (CollisionUtils.AABBOverlap(player.hitBox, enemy.hitBox)) {
				endGame();
			}
		}
	}
	
	private function startGame() {
		countDown.visible = false;
		
		enemyManager = new EnemyManager(enemyGroup, player);
		
		gameRunning = true;
	}
	
	private function endGame() {
		gameRunning = false;
		
		if(enemyManager != null) {
			GameData.lastTime = enemyManager.playTime;
			GameData.bestTime = Math.max(GameData.bestTime, enemyManager.playTime);
			
			GameData.lastLevel = enemyManager.level;
			GameData.bestLevel = Math.floor(Math.max(GameData.bestLevel, enemyManager.level));		
		}
		
		Game.instance.changeState(new EndState());
	}
	
	private function generateMap(width:Int, height:Int):String {
		var map:String = "";
		
		for (i in 0...height) {
			for (j in 0...width) {
				map += (i == 0 || j == 0 || j == width - 1 || i == height - 1 ? "2" : "-1")
					+ (j < width - 1 ? "," : "");
			}
			map += "\n";
		}
		
		return map;
	}
	
}