package game.monsters 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.mainObjects.Tower;
	import game.pickUps.BrickCollectible;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	import game.monsters.HpBar;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Monster extends MovingGameObject
	{
		//animations / art
		protected var preAnim : Array;
		
		protected const MOVEMENT_ANIM : int = 0;
		protected const ATTACK_ANIM : int = 1;
		protected const DEATH_ANIM : int = 2;
		
		protected var animations : Array = [];
		
		//checks
		protected var attacking : Boolean = false;
		protected var attackHitFrame : int = 1;
		protected var curAttackingTower : Tower;
		
		//stats
		protected var hpBar : HpBar;
		protected var health : int;
		protected var attackDmg : int;
		protected var bricksToDrop : int;
		
		public function Monster(wave : int,direction : int) 
		{
			setStats(wave);
			_dir = direction;
			drawMonster();
		}
		
		protected function setStats(wave : int):void 
		{
			health += wave * (health * 0.05);
			attackDmg += wave * (attackDmg * 0.02);
			bricksToDrop = Math.floor(Math.random() * ((health * 0.15) / attackDmg)) + 2;
			hpBar = new HpBar(health);
			trace("HP: "+ health + " DMG " + attackDmg);
		}
		protected function drawMonster():void 
		{
			for (var i : uint = 0; i < preAnim.length; i++) {
				var anim : MovieClip = preAnim[i];
				addChild(anim);
				animations.push(anim);
			}
			
			switchAnim(MOVEMENT_ANIM);
			
			//place HealthBar
			hpBar.x = x - hpBar.width / 2;
			hpBar.y -= height / 1.2;
			
			addChild(hpBar);
			if (dir == -1) {
				hpBar.x += hpBar.width;
				hpBar.scaleX *= -1;
			}
		}
		
		protected function switchAnim(animInt : int) :void {
			for (var i : uint = 0; i < animations.length; i++) {
				animations[i].visible = false;
				animations[i].stop();
			}
			animations[animInt].visible = true;
			animations[animInt].play();
		}
		
		public function getDamage(dmg : int) :void {
			health -= dmg;
			if(!attacking && dmg != int.MAX_VALUE){
				this.x += scaleX * -1 * (dmg * 0.1);
			}
			if (health <= 0) {
				health = 0;
				startDeath();
			}
			hpBar.scaleBar(health);
		}
		protected function dropBricks(amount : int):void 
		{
			for (var i : int = 0; i < amount; i++) {
				var brick : BrickCollectible = new BrickCollectible();
				brick.x = x + ((brick.width + 1) * i);
				brick.y = y;
				parent.addChild(brick);
			}
		}
		override public function update():void 
		{
			super.update();
			checkAnimationEvents();
		}
		override public function onCollision(other:GameObject):void 
		{
			if (other is Tower && attacking == false) {
				attack(other as Tower);
			}
		}
		
		private function checkAnimationEvents():void 
		{
			if (animations[ATTACK_ANIM].currentFrame == animations[ATTACK_ANIM].totalFrames) {
				attacking = false;
			}else if (animations[ATTACK_ANIM].currentFrame == attackHitFrame) {
				if(curAttackingTower != null){
					curAttackingTower.damageTower(attackDmg);
				}
			}
			if (animations[DEATH_ANIM].currentFrame == animations[DEATH_ANIM].totalFrames) {
				animations[DEATH_ANIM].stop();
				death();
			}
		}
		protected function startDeath():void 
		{
			collider = false;
			_dir = 0;
			attackDmg = 0;
			switchAnim(DEATH_ANIM);
		}
		private function death():void 
		{
			dropBricks(bricksToDrop);
			removeObject();
		}
		
		protected function attack(tower : Tower):void 
		{
			_dir = 0;
			switchAnim(ATTACK_ANIM);
			curAttackingTower = tower;
			attacking = true;
		}
		
	}

}