package gbjam5;

import kge.core.CoreBase;
import kge.core.Game;
import kge.core.Group;
import kha.Assets;
import kha.Sound;

import haxe.Constraints.Function;

class EnemyManager extends CoreBase
{

	private var enemyGroup:Group<EnemyBase>;
	
	private var player:Player;
	
	public var level:Int;
	private var levelUpTime:Float;
	private var levelUpReduction:Float;
	public var playTime:Float;
	
	private var spawnFunctions:Array<Function>;
	private var spawnTimers:Array<Float>;
	private var spawnTimersEnd:Array<Float>;
	
	public function new(enemyGroup:Group<EnemyBase>, player:Player) 
	{
		super();
		
		this.enemyGroup = enemyGroup;
		this.player = player;
		
		level = 1;
		levelUpTime = 5;
		levelUpReduction = 0.1;
		
		spawnFunctions = [];
		spawnTimers = [];
		spawnTimersEnd = [];
		
		addSpawnFunction(spawnHorizontalEnemy, 2);
		addSpawnFunction(spawnVerticalEnemy, 2, 1);
		
		playSound(Assets.sounds.LevelUp);
	}
	
	override public function update() 
	{
		super.update();
		
		playTime += Game.deltaTime;
		
		var func:Function;
		var timer:Float;
		var timerEnd:Float;
		var i = 0;
		while(i < spawnFunctions.length) {
			spawnTimers[i] += Game.deltaTime;
			timer = spawnTimers[i];
			timerEnd = spawnTimersEnd[i];
			func = spawnFunctions[i];
			
			while (timer > timerEnd) {
				func();
				spawnTimers[i] -= timerEnd;
				timer = spawnTimers[i];
			}
			
			if (playTime > levelUpTime * level) {
				levelUp();
			}
			
			++i;
		}
	}
	
	private function playSound(sound:Sound, playTime:Float = -1) {
		Game.audio.playSoundSection(sound, playTime);
	}
	
	private function addSpawnFunction(func:Function, time:Float, timerOffset:Float = 0) {		
		spawnFunctions.push(func);
		spawnTimers.push(timerOffset);
		spawnTimersEnd.push(time);		
	}
	
	private function levelUp() {
		level++;
		
		playSound(Assets.sounds.LevelUp);
		
		switch(level) {
			case 2:
				addSpawnFunction(spawnVerticalEnemy, 2, 1);
			case 3:
				addSpawnFunction(spawnHorizontalEnemy, 2, 0.5);
			case 4:
				addSpawnFunction(spawnVerticalEnemy, 1, 0.2);
			case 5:
				addSpawnFunction(spawnVerticalEnemy, 1, 0.7);
			case 6:
				addSpawnFunction(spawnHorizontalDouble, 3, 0);
			case 7:
				addSpawnFunction(spawnHorizontalDouble, 3, 1);
			case 8:
				addSpawnFunction(spawnHorizontalDouble, 3, 2);
			case 9:
				addSpawnFunction(spawnVerticalRightEnemy, 3, 0);
			case 10:
				addSpawnFunction(spawnVerticalRightEnemy, 3, 1);
			case 11:
				addSpawnFunction(spawnVerticalRightEnemy, 3, 2);
			case 12:
				addSpawnFunction(spawnVerticalRightEnemy, 3, 1);
		}
	}
	
	private function spawnVerticalEnemy() {
		getLinear().reset(-8, player.y);
		
		playSound(Assets.sounds.PC3, 0.2);
	}
	
	private function spawnVerticalRightEnemy() {
		getLinear().reset(Game.width + 8, player.y);
		
		playSound(Assets.sounds.PC3, 0.2);
	}
	
	private function spawnHorizontalEnemy() {
		getLinear().reset(player.x, -8);
		
		playSound(Assets.sounds.PD3, 0.2);
	}
	
	private function spawnHorizontalDouble() {
		getLinear().reset(player.x + 8, -8);
		getLinear().reset(player.x - 8, -8);
		
		playSound(Assets.sounds.PE3, 0.3);
	}
	
	private function getLinear() {
		for (enemy in enemyGroup) {
			if (enemy.x < -Game.width || enemy.x > Game.width * 2 || enemy.y < -Game.height || enemy.y > Game.height * 2) {
				return enemy;
			}
		}
		
		var enemy:EnemyLinear = new EnemyLinear(0, 0);
		enemyGroup.add(enemy);
		return enemy;
	}
	
}