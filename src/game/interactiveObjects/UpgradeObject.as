package game.interactiveObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.mainObjects.Player;
	import gameControl.GameObject;
	import placeholderAssets.PlayerAttackPlaceHolder;
	
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
			interActive = true;
			drawUpgradeObject();
			selectUpgradeScreen();
			
			addChild(upgradeScreen);
			
			upgradeScreen.visible = false;
		}
		
		private function drawUpgradeObject():void 
		{
			addChild(art);
		}
		
		protected function selectUpgradeScreen():void 
		{
			upgradeScreen.y -= art.height / 1.5;
		}
		
		override public function onInteraction(InteractingObject:GameObject):void 
		{
			if (upgradeScreen.visible == false) {
				upgradeScreen.selectUpgradeTarget(InteractingObject as Player);
				upgradeScreen.visible = true;
			}else {
				upgradeScreen.buy();
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