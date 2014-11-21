package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.BackGround;
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
		private var camera : Rectangle;
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
			addPlayer();
			addChild(ui);
			waveSystem.setWave(1);
		}
		private function nextLevel(e : Event) :void {
			_level ++;
			waveSystem.setWave(1);
			buildTower();
			player.x = stage.stageWidth / 2;
			player.y = (stage.stageHeight - player.height / 2);
			addChild(player);
		}
		private function buildTower():void 
		{
			if (contains(tower)) {
				tower.removeObject();
				tower = null;
			}
			tower = new Tower(level);
			
			tower.x = stage.stageWidth / 2;
			tower.y = (stage.stageHeight - tower.height) - 30;
			
			addChild(tower);
		}
		private function addBackground():void 
		{
			backGround = new BackGround();
			backGround.x = backGround.width / 3;
			addChild(backGround);
		}
		private function addPlayer():void 
		{	
			player.x = stage.stageWidth / 2;
			player.y = (stage.stageHeight - player.height / 2);
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