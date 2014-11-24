package game.interactiveObjects.attackUpgrade 
{
	import game.interactiveObjects.UpgradeObject;
	import placeholderAssets.PlayerAttackPlaceHolder;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class AttackUpgradeObject extends UpgradeObject 
	{
		
		public function AttackUpgradeObject() 
		{
			art = new PlayerAttackPlaceHolder();
			super();
		}
		
		override protected function selectUpgradeScreen():void 
		{
			upgradeScreen = new AttackUpgradeScreen();
			super.selectUpgradeScreen();
		}
		
	}

}