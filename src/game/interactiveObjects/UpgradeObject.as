package game.interactiveObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.mainObjects.Player;
	import gameControl.GameObject;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UpgradeObject extends GameObject 
	{
		protected var art : Sprite = new Sprite();
		protected var upgradeScreen : UpgradeScreen;
		
		public function UpgradeObject() 
		{
			super();
			interActive = true;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			drawUpgradeObject();
			
			upgradeScreen = new UpgradeScreen(); // attackupgradeScreen or something
			upgradeScreen.x = art.width / 2;
			addChild(upgradeScreen);
			
			upgradeScreen.visible = false;
			
		}
		
		private function drawUpgradeObject():void 
		{
			art.graphics.beginFill(0x00FF00);
			art.graphics.drawRect(0, 0, 20, 20);
			art.graphics.endFill();
			addChild(art);
		}
		
		override public function onInteraction(InteractingObject:GameObject):void 
		{
			super.onInteraction(InteractingObject);
			if (upgradeScreen.visible == false) {
				upgradeScreen.selectUpgradeTarget(InteractingObject as Player);
				upgradeScreen.visible = true;
			}else {
				upgradeScreen.buy();
			}
			//pop up upgrade screen and give the player who activated it. after pop up use again to use the screen to upgrade needed stats 
			//use the ontriggerexit to exit the shop and make the screen go away
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