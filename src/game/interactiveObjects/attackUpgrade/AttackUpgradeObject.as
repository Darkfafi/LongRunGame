package game.interactiveObjects.attackUpgrade 
{
	import game.interactiveObjects.UpgradeObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class AttackUpgradeObject extends UpgradeObject 
	{
		
		public function AttackUpgradeObject() 
		{
			art = new AttFornuisAnim();
			super();
		}
		
		override protected function selectUpgradeScreen():void 
		{
			upgradeScreen = new AttackUpgradeScreen();
			super.selectUpgradeScreen();
		}
		
	}

}