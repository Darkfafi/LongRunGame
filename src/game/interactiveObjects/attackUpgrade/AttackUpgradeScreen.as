package game.interactiveObjects.attackUpgrade 
{
	import game.interactiveObjects.UpgradeScreen;
	import game.mainObjects.Player;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class AttackUpgradeScreen extends UpgradeScreen 
	{
		
		public function AttackUpgradeScreen() 
		{
			super();
		}
		override public function selectUpgradeTarget(player:Player):void 
		{
			super.selectUpgradeTarget(player);
			effectText.changeText(player.attackDmg + " +  5");
		}
		override protected function upgradePlayer():void 
		{
			super.upgradePlayer();
			target.attackDmg += 5;
			effectText.changeText(target.attackDmg + " +  5 <br> UPGRADED!");
		}
		
	}

}