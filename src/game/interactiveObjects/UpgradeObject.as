package game.interactiveObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.mainObjects.Player;
	import gameControl.GameObject;
	import soundTools.SoundManager;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UpgradeObject extends GameObject 
	{
		protected var art : Sprite;
		protected var upgradeScreen : UpgradeScreen;
		
		public function UpgradeObject() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			interActive = true;
			drawUpgradeObject();
			selectUpgradeScreen();
			
			addChild(upgradeScreen);
			
			upgradeScreen.visible = false;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hitBox.width = 20;
			hitBox.height = 20
		}
		private function drawUpgradeObject():void 
		{
			addChild(art);;
		}
		
		protected function selectUpgradeScreen():void 
		{
			upgradeScreen.y -= art.height / 1.5;
		}
		
		override public function onInteraction(InteractingObject:GameObject):void 
		{
			var player : Player = InteractingObject as Player;
			if (upgradeScreen.visible == false) {
				upgradeScreen.selectUpgradeTarget(InteractingObject as Player);
				SoundManager.playSound(SoundManager.UPGRADE_OPENSCREEN_SOUND,0,150);
				upgradeScreen.visible = true;
			}else {
				if (player.bricksCarrying > 0) {	
					SoundManager.playSound(SoundManager.BRICKS_IN_FURNACE_SOUND);
					upgradeScreen.buy();
				}
			}
		}
		override public function onCollisionExit(other:GameObject):void 
		{
			super.onCollisionExit(other);
			if (other is Player) {
				upgradeScreen.visible = false;
			}
		}
	}

}