package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.mainObjects.Player;
	import gameControl.GameController;
	import placeholderAssets.BackGround;
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
			player.x = stage.stageWidth / 2;
			player.y = (stage.stageHeight - player.height) - 10;
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