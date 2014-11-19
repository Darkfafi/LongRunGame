package game.monsters 
{
	import gameControl.MovingGameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Monster extends MovingGameObject
	{
		protected var health : int;
		protected var attackDmg : int;
		
		public function Monster(hp : int, attackDamage : int) 
		{
			health = hp;
			attackDmg = attackDamage;
		}
		
	}

}