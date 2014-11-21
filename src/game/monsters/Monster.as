package game.monsters 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.mainObjects.Tower;
	import game.pickUps.BrickCollectible;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Monster extends MovingGameObject
	{
		//animations / art
		protected var preAnim : Array = [];
		
		protected const MOVEMENT_ANIM : int = 0;
		protected const ATTACK_ANIM : int = 1;
		protected const DEATH_ANIM : int = 2;
		
		protected var animations : Array = [];
		
		//checks
		protected var attacking : Boolean = false;
		
		//stats
		protected var health : int;
		protected var attackDmg : int;
		protected var bricksToDrop : int;
		
		public function Monster(wave : int,direction : int) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			setStats(wave);
			//moet berekend worden met waar de tower staat.
			_dir = direction;
		}
		
		protected function setStats(wave : int):void 
		{
			health += wave * health / 4;
			attackDmg += wave * attackDmg / 4;
			bricksToDrop = Math.floor(Math.random() * attackDmg / 4) + 2;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			drawMonster();
		}
		
		protected function drawMonster():void 
		{
			for (var i : uint = 0; i < preAnim.length; i++) {
				var anim : MovieClip = preAnim[i];
				anim.visible = false;
				anim.stop();
				addChild(anim);
				animations.push(anim);
			}
			animations[MOVEMENT_ANIM].visible = true;
		}
		
		protected function switchAnim(animInt : int) :void {
			for (var i : uint = 0; i < animations.length; i++) {
				animations[i].visible = false;
				animations[i].gotoAndStop(1);
			}
			animations[animInt].visible = true;
			animations[animInt].play();
		}
		public function getDamage(dmg : int) :void {
			health -= dmg;
			this.x += scaleX * -1 * (dmg * 0.1);
			if (health <= 0) {
				health = 0;
				death();
			}
		}
		
		protected function death():void 
		{
			//deathAnim
			dropBricks(bricksToDrop);
			_dir = 0;
			attackDmg = 0;
			switchAnim(DEATH_ANIM);
			removeObject();
		}
		
		protected function dropBricks(amount : int):void 
		{
			for (var i : int = 0; i < amount; i++) {
				var brick : BrickCollectible = new BrickCollectible();
				brick.x = this.x + ((brick.width + 1) * i);
				brick.y = this.y;
				parent.addChild(brick);
			}
		}
		override public function onCollision(other:GameObject):void 
		{
			if (other is Tower && attacking == false) {
				attack(other as Tower);
			}
		}
		
		protected function attack(tower : Tower):void 
		{
			_dir = 0;
			switchAnim(ATTACK_ANIM);
			tower.damageTower(attackDmg);
			trace(attackDmg);
			attacking = true;
			//als attack animation klaar is. attacking weer terug op falsezodat hij weerk kan aanvallen.
		}
		
	}

}