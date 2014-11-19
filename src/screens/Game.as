package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.BackGround;
	import game.mainObjects.Player;
	import game.mainObjects.Tower;
	import gameControl.GameController;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		//stage objects
		private var camera : Rectangle;
		private var gameController : GameController;
		private var gameRunning : Boolean = true;
		
		private var backGround : Sprite;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			gameController = new GameController(this);
			beginGame();
			
		}
		
		private function beginGame():void 
		{
			addBackground();
			addPlayer();
		}
		private function addBackground():void 
		{
			backGround = new BackGround();
			backGround.x = backGround.width / 3;
			addChild(backGround);
			
		}
		private function addPlayer():void 
		{
			var player : Player = new Player();
			var tower : Tower = new Tower(1);
			
			player.x = stage.stageWidth / 2;
			player.y = (stage.stageHeight - player.height) - 10;
			
			tower.x = player.x;
			tower.y = player.y;
			addChild(tower);
			addChild(player);
		}
		private function update(e:Event):void 
		{
			if (gameRunning) {
				gameController.update();
			}
		}
	}

}