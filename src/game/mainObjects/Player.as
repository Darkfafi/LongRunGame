package game.mainObjects 
{
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import game.pickUps.BrickCollectible;
	import gameControl.GameObject;
	import gameControl.MovingGameObject;
	import soundTools.SoundManager;
	
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
		private const TOWER_BUILD_ANIM : int = 3;
		
		private var animations : Array = [];
		private var displayX : Sprite = new XDisplayInteractive();
		private var canShoot : Boolean = true;
		
		//stats
		public var attackDmg : int;
		public var bricksCarrying : int;
		public var brickCapacity : int;
		
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
			_speed = 5;
			attackDmg = 15;
			brickCapacity = 10;
			bricksCarrying = brickCapacity / 2;
		}
		private function drawPlayer():void 
		{
			var preAnim : Array = [new KnightIdle, new KnightWalk, new KnightShoot, new KnightTowerBuild];
			for (var i : uint = 0; i < preAnim.length; i++) {
				var anim : MovieClip = preAnim[i] as MovieClip;
				anim.visible = false;
				anim.stop();
				animations.push(anim);
				addChild(anim);
			}
			switchAnim(IDLE_ANIM);
			
			displayX.y -= height;
			displayX.visible = false;
			addChild(displayX);
		}
		
		private function switchAnim(animInt : int) :void {
			for (var i : int = animations.length - 1; i >= 0; i--) {
				animations[i].visible = false;
				animations[i].gotoAndStop(1);
			}
			animations[animInt].visible = true;
			animations[animInt].play();
		}
		public function buildUpTower() :void {
			switchAnim(TOWER_BUILD_ANIM);
			SoundManager.playToEnd(SoundManager.BAG_SOUND);
			//bag sound
		}
		override public function update():void 
		{
			super.update();
			animCheck();
		}
		
		private function animCheck():void 
		{
			if (animations[ATTACK_ANIM].currentFrame == animations[ATTACK_ANIM].totalFrames) {
				canShoot = true;
			}
			if (animations[TOWER_BUILD_ANIM].currentFrame == animations[TOWER_BUILD_ANIM].totalFrames) {
				switchAnim(IDLE_ANIM);
			}else if(animations[TOWER_BUILD_ANIM].currentFrame == 25) {
				SoundManager.playSound(SoundManager.BUILD_TOWER_SOUND);
			}
		}
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT) {		
				_dir = -1;
			}else if (e.keyCode == Keyboard.RIGHT) {
				_dir = 1;
			}
			if ( e.keyCode == Keyboard.Z) {
				playerAttack();
			}
			if (e.keyCode == Keyboard.X) {
				if (collidedObject && collidedObject.interActive && canShoot) {
					collidedObject.onInteraction(this);
				}
			}
			if(canShoot){
				displayX.scaleX = dir * -1;
			}
		}
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) {
				_dir = 0;
			}
		}
		override public function movement():void 
		{
			if(canShoot && animations[TOWER_BUILD_ANIM].visible == false){
				super.movement();
				if (dir == -1 && animations[MOVEMENT_ANIM].visible == false || dir == 1 && animations[MOVEMENT_ANIM].visible == false) {
					switchAnim(MOVEMENT_ANIM);
				}else if (dir == 0 && animations[IDLE_ANIM].visible == false) {
					switchAnim(IDLE_ANIM);
				}
			}
		}
		private function playerAttack():void 
		{
			if (canShoot && animations[TOWER_BUILD_ANIM].visible == false) {
				canShoot = false;
				switchAnim(ATTACK_ANIM);
				playerShoot();
			}
		}
		private function playerShoot():void 
		{
			var bullet : Bullet = new Bullet(attackDmg, scaleX);
			bullet.x = x + width / 3 * scaleX;
			bullet.y = y - height / 3;
			parent.addChild(bullet);
			SoundManager.playSound(SoundManager.SHOOT_SOUND);
			this.x += scaleX * -1;
		}
		
		override public function onCollisionEnter(other:GameObject):void 
		{
			super.onCollisionEnter(other);
			if (other.interActive && displayX.visible == false) {
				displayX.visible = true;
			}
		}
		override public function onCollisionExit(other:GameObject):void 
		{
			super.onCollisionExit(other);
			if (other.interActive && displayX.visible == true) {
				displayX.visible = false;
			}
		}
		override public function onCollision(other:GameObject):void 
		{
			super.onCollision(other);
			if (other is BrickCollectible) {
				if(bricksCarrying < brickCapacity){
					other.removeObject();
					bricksCarrying ++;
					SoundManager.playSound(SoundManager.BAG_SOUND);
				}
			}	
		}
		override public function destroy():void 
		{
			super.destroy();
			for (var i : int = 0; i < animations.length; i++) {
				animations[i].stop();
			}
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
	}
}