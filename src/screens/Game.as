package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.BackGround;
	import game.interactiveObjects.attackUpgrade.AttackUpgradeObject;
	import game.interactiveObjects.capacityUpgrade.CapacityUpgradeObject;
	import game.interactiveObjects.UpgradeObject;
	import game.mainObjects.Player;
	import game.mainObjects.Tower;
	import game.monsters.Golem;
	import game.monsters.Monster;
	import game.UI;
	import game.WaveSystem;
	import gameControl.GameController;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		private var _level : int = 1;
		
		//stage objects
		private var ui : UI;
		public var gameController : GameController;
		private var gameRunning : Boolean = true;
		private var waveSystem : WaveSystem;
		
		public var backGround : Sprite;
		//
		private var player : Player = new Player();
		private var tower : Tower = new Tower(0);
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Tower.GAME_WON, nextLevel);
			gameController = new GameController(this);
			waveSystem = new WaveSystem(this);
			ui = new UI(gameController);
			
			beginGame();
			
		}
		
		private function beginGame():void 
		{
			addBackground();
			buildTower();
			placeUpgradeObjects();
			addPlayer();
			addChild(ui);
			waveSystem.setWave(1);
		}
		
		private function nextLevel(e : Event) :void {
			//next level word getriggert door gotoNextLevel functie die de conceptart laat zien van level won. alle monsters delete en de dontSpawn aanzet. En een timer zet dat na zo veel sec next level getriggert word
			_level ++;
			ui.updateLevelText();
			waveSystem.dontSpawn();
			deleteAllMonsters();
			waveSystem.setWave(1);
			
			buildTower();
			addChild(player);
		}
		
		private function deleteAllMonsters():void 
		{
			var allMonsters : Array = gameController.lisOfObjectType(Monster);
			
			for (var i : int = allMonsters.length - 1; i >= 0; i--) {
				var monster : Monster = allMonsters[i] as Monster;
				monster.getDamage(int.MAX_VALUE);
			}
		}
		
		private function placeUpgradeObjects():void 
		{
			var upgAttack : UpgradeObject = new AttackUpgradeObject();
			var upgCapacity : UpgradeObject = new CapacityUpgradeObject();
			upgAttack.x = backGround.x - stage.stageWidth / 3;
			upgCapacity.x =  backGround.x + stage.stageWidth / 3
			upgAttack.y = 550;
			upgCapacity.y = upgAttack.y;
			addChildAt(upgAttack,1);
			addChildAt(upgCapacity,1);
		}
		private function buildTower():void 
		{
			if (contains(tower)) {
				tower.removeObject();
				tower = null;
			}
			tower = new Tower(level);
			
			tower.x = backGround.x;
			tower.y = (stage.stageHeight - tower.height / 2) - 30;
			
			addChildAt(tower,1);
		}
		private function addBackground():void 
		{
			backGround = new BackGround();
			backGround.x = backGround.width / 3;
			addChildAt(backGround,0);
		}
		private function addPlayer():void 
		{	
			player.x = stage.stageWidth / 2;
			player.y = (stage.stageHeight - player.height / 5) + 11;
			player.rotationY = 180;
			addChild(player);
		}
		private function update(e:Event):void 
		{
			if (gameRunning) {
				gameController.update();
				ui.update();
			}
		}
		
		public function get level():int 
		{
			return _level;
		}
	}

}