package game.mainObjects 
{
	import flash.display.Sprite;
	import game.monsters.Monster;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Bullet extends MovingGameObject
	{
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
			
			fallSpeed += currentDropSpeed;
			y += fallSpeed;
			
			if (y > parent.stage.stageHeight) {
				removeObject();
			}
		}
		private function drawBullet():void 
		{
			bulletArt.graphics.beginFill(0x000000, 1);
			bulletArt.graphics.drawCircle(0, 0, 5);
			bulletArt.graphics.endFill();
			addChild(bulletArt);
		}
		override public function onCollision(other:GameObject):void 
		{
			super.onCollision(other);
			if (other is Monster) {
				var monster : Monster = other as Monster;
				monster.getDamage(bulletDmg);
				//impact (explosion or something)
				removeObject();
			}
		}
		
	}

}