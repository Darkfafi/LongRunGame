package game.mainObjects 
{
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import game.pickUps.BrickCollectible;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	import placeholderAssets.PlayerAttackPlaceHolder;
	import placeholderAssets.PlayerIdlePlaceHolder;
	import placeholderAssets.PlayerMovePlaceHolder;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends MovingGameObject 
	{
		//Art / Animations
		private const IDLE_ANIM : int = 0;
		private const MOVEMENT_ANIM : int = 1;
		private const ATTACK_ANIM : int = 2;
		
		private var animations : Array = [];
		
		//stats
		private var attackDmg : int;
		private var bricksCarrying : int;
		private var brickCapacity : int;
		
		public function Player() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			setDefaultStats();
			drawPlayer();
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function setDefaultStats():void 
		{
			_speed = 3;
			attackDmg = 10;
			brickCapacity = 10;
		}
		private function drawPlayer():void 
		{
			var preAnim : Array = [new PlayerIdlePlaceHolder, new PlayerMovePlaceHolder, new PlayerAttackPlaceHolder];
			for (var i : uint = 0; i < preAnim.length; i++) {
				var anim : MovieClip = preAnim[i];
				anim.visible = false;
				anim.stop();
				addChild(anim);
				animations.push(anim);
			}
			animations[IDLE_ANIM].visible = true;
		}
		
		private function switchAnim(animInt : int) :void {
			for (var i : uint = 0; i < animations.length; i++) {
				animations[i].visible = false;
				animations[i].gotoAndStop(1);
			}
			animations[animInt].visible = true;
			animations[animInt].play();
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT) {
				_dir = -1;
				switchAnim(MOVEMENT_ANIM);
			}else if (e.keyCode == Keyboard.RIGHT) {
				_dir = 1;
				switchAnim(MOVEMENT_ANIM);
			}
			if ( e.keyCode == Keyboard.Z) {
				playerAttack();
			}
			if (e.keyCode == Keyboard.X) {
				if (collidedObject && collidedObject.interActive) {
					trace("use");
					collidedObject.onInteraction();
				}
			}
		}
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) {
				_dir = 0;
				switchAnim(IDLE_ANIM);
			}
		}
		private function playerAttack():void 
		{
			//if(animations[ATTACK_ANIM].currentFrame == animations[ATTACK_ANIM].totalFrames){
			switchAnim(ATTACK_ANIM);
			playerShoot();
		}
		
		private function playerShoot():void 
		{
			var bullet : Bullet = new Bullet(attackDmg, scaleX);
			bullet.x = x + width / 2;
			bullet.y = y + height / 2.5;
			parent.addChild(bullet);
		}
		
		override public function onCollision(other:GameObject):void 
		{
			super.onCollision(other);
			if (other is BrickCollectible) {
				if(bricksCarrying < brickCapacity){
					other.removeObject();
					bricksCarrying ++;
				}
			}
		}
	}
}