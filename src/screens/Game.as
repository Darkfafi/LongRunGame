package screens 
{
	import buttons.ToggleButton;
	import events.HudEvent;
	import flash.display.MovieClip;
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
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		public static const BACK_TO_MENU : String = "backToMenu";
		
		private var _level : int = 1;
		
		private var countDown : int;
		
		//stage objects
		private var endscreen : Sprite = new EndScreen();
		private var explosionAnim : MovieClip;
		
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
			
			SoundManager.playMusic(SoundManager.GAME_MUSIC,9999,2000);
			
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Tower.GAME_WON, startNextLevelAnim);
			addEventListener(Tower.GAME_LOST, endGame);
			
			gameController = new GameController(this);
			waveSystem = new WaveSystem(this);
			ui = new UI(gameController);
			beginGame();
			
		}
		
		private function endGame(e:Event):void 
		{
			player.destroy();
			gameRunning = false
			stage.addChild(endscreen);
			endscreen.alpha = 0.8;
			SoundManager.playMusic(SoundManager.DEFEAT_SOUND, 0);
			countDown = setInterval(quitGame, 3000);
		}
		
		
		private function quitGame():void 
		{
			clearInterval(countDown);
			var cam : Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			this.root.scrollRect = cam;
			stage.removeChild(endscreen);
			dispatchEvent(new Event(BACK_TO_MENU, true));
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
		private function startNextLevelAnim(e:Event):void 
		{
			explosionAnim  = new ExplosionFlare();
			addChild(explosionAnim);
			SoundManager.playSound(SoundManager.TOWER_NUKE_SOUND);
			explosionAnim.x = backGround.width / 3 + 15;
		}
		private function nextLevel() :void {
			_level ++;
			ui.updateLevelText();
			waveSystem.dontSpawn();
			deleteAllMonsters();
			waveSystem.setWave(1);
			
			buildTower();
			addChild(player);
			addChild(explosionAnim);
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
			tower.y = (stage.stageHeight - tower.height / 2);
			
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
			if(explosionAnim != null){
				if (explosionAnim.currentFrame == explosionAnim.totalFrames) {
					explosionAnim.gotoAndStop(1);
					removeChild(explosionAnim);
					explosionAnim = null;
				}else if (explosionAnim.currentFrame == 30) {
					nextLevel();
				}
			}
		}
		
		public function get level():int 
		{
			return _level;
		}
		
		override public function destroy():void 
		{
			gameController.destroy();
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Tower.GAME_WON, nextLevel);
			removeEventListener(Tower.GAME_LOST, quitGame);
			super.destroy();
		}
	}
}