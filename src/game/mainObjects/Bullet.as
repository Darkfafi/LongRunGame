package game.mainObjects 
{
	import flash.display.Sprite;
	import game.monsters.Monster;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Bullet extends MovingGameObject
	{
		private var explosion : ExplosionArt;
		private var currentDropSpeed : Number = 0;
		private var fallSpeed : Number = 0;
		private var bulletArt : Sprite = new Sprite();
		private var bulletDmg : int;
		
		public function Bullet(bulletDamage : int, direction : int) 
		{
			_speed = 18;
			bulletDmg = bulletDamage;
			_dir = direction;
			
			drawBullet();
		}
		override public function movement():void 
		{
			super.movement();
			currentDropSpeed += 0.01;
			
			if (y > parent.stage.stageHeight) {
				removeObject();
			}
			if(explosion != null){
				if (explosion.currentFrame == explosion.totalFrames) {
					removeObject();
				}
			}else {
				fallSpeed += currentDropSpeed;
				y += fallSpeed;
			}
		}
		private function drawBullet():void 
		{
			bulletArt = new CannonBall();
			addChild(bulletArt);
		}
		override public function onCollision(other:GameObject):void 
		{
			super.onCollision(other);
			if (other is Monster) {
				collider = false;
				if(contains(bulletArt)){
					removeChild(bulletArt);
				}
				var monster : Monster = other as Monster;
				monster.getDamage(bulletDmg);
				
				_dir = 0;
				explosion = new ExplosionArt();
				SoundManager.playSound(SoundManager.HIT_SOUND);
				if(0.3 + (0.02 * (bulletDmg - 10) < 1.2)){
					explosion.scaleX = 0.3 + (0.02 * (bulletDmg - 10));
					explosion.scaleY = explosion.scaleX;
				}
				addChild(explosion);
			}
		}
	}
}