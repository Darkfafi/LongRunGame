package game 
{
	import events.HudEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.mainObjects.Player;
	import game.mainObjects.Tower;
	import gameControl.GameController;
	import gameControl.GameObject;
	import gameControl.HudTextField;
	import screens.Game;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UI extends GameObject
	{
		
		private var gameController : GameController;
		//----------------textFields------------------\\
		
		private var uibg : Sprite = new UIBackArt();
		
		private var levelText : HudTextField = new HudTextField("Level");
		private var waveText : HudTextField = new HudTextField("Wave");
		private var bricksLeftText : HudTextField = new HudTextField("Bricks Tower Left");
		private var playerBricks : HudTextField = new HudTextField("Player Bricks");
		private var monstersLeftText : HudTextField = new HudTextField("Monsters Left");
		
		//objects to track
		private var listObjects : Array = [];
		
		public function UI(_gameController : GameController) 
		{
			gameController = _gameController;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(WaveSystem.NEXT_WAVE, updateWaveText);
			stage.addEventListener(Tower.GAME_WON, gameWon);
			addUiToScreen();
			updateLevelText();
		}
		
		private function gameWon(e:Event):void 
		{
			updateLevelText();
		}
		
		public function updateLevelText():void 
		{
			var _game : Game = parent as Game;
			levelText.changeText("LEVEL " + _game.level.toString());
		}
		
		public function update() :void {
			listObjects = gameController.getAllObjects();
			var l : int = listObjects.length;
			var curObj : GameObject;
			for (var i : int = l - 1; i >= 0; i--) {
				curObj = listObjects[i] as GameObject;
				if (curObj is Player) {
					var player : Player = curObj as Player;
					updatePlayerBricks(player.bricksCarrying,player.brickCapacity);
				}
				if (curObj is Tower) {
					var tower : Tower = curObj as Tower;
					updateBricksLeftText(tower.totalBricks,tower.maxBricks);
				}
			}
		}
		private function updateWaveText(e:Event):void 
		{
			var event : HudEvent = e as HudEvent;
			waveText.changeText("WAVE " + event.info);
		}
		private function updateBricksLeftText(totalBricks:int, maxBricks:int):void 
		{
			bricksLeftText.changeText("Tower Bricks: <br>" + totalBricks + " / " + maxBricks);
		}
		
		private function updatePlayerBricks(bricksCarrying:int, brickCapacity:int):void 
		{
			playerBricks.changeText("Player Bricks: <br>" + bricksCarrying + " / " + brickCapacity);
		}
		
		private function addUiToScreen():void 
		{
			uibg.x -= 20;
			uibg.y -= uibg.height / 2;
			uibg.scaleX = 1.05;
			uibg.alpha = 0.8;
			stage.addChildAt(uibg,1);
			
			levelText.x = stage.stageWidth / 2 - 10;
			waveText.x = levelText.x;
			waveText.y = levelText.y + waveText.height / 4;
			playerBricks.x += 50;
			bricksLeftText.x = stage.stageWidth - bricksLeftText.width / 1.5;
			
			stage.addChild(levelText);
			stage.addChild(waveText);
			stage.addChild(bricksLeftText);
			stage.addChild(playerBricks);
		}
		override public function destroy():void 
		{
			super.destroy();
			stage.removeChild(uibg);
			stage.removeChild(levelText);
			stage.removeChild(waveText);
			stage.removeChild(bricksLeftText);
			stage.removeChild(playerBricks);
			
			stage.removeEventListener(WaveSystem.NEXT_WAVE, updateWaveText);
			stage.removeEventListener(Tower.GAME_WON, gameWon);
		}
	}

}