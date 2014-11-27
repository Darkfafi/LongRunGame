package gameControl 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		public static const ADDED : String = "addedGameOb";
		public static const REMOVED : String = "removedGameOb";
		
		public var info : int;
		
		public var colliding : Boolean = false;
		public var collidedObject : GameObject;
		
		private var removing : Boolean = false;
		
		protected var hitBox : Sprite;
		
		//tags
		public var collider : Boolean = true;
		public var interActive : Boolean = false;
		
		public function GameObject() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			dispatchEvent(new Event(ADDED,true));
			if(collider){
				hitBox = new Sprite();
				//hitBox.graphics.beginFill(0x000000, 0.5);
				hitBox.graphics.drawRect( -width / 2, -height, width, height);
				//hitBox.graphics.endFill();
				addChild(hitBox);
			}
		}
		
		public function willCollide(other : GameObject) : Boolean {
			var result : Boolean = false;
			if (hitBox.hitTestObject(other.hitBox)) {
				result = true;
			}
			return result;
		}
		
		public function onCollisionEnter(other : GameObject):void {
			colliding = true;
		}
		
		public function onCollision(other : GameObject) :void {
			collidedObject = other;
		}
		
		public function onCollisionExit(other : GameObject):void {
			colliding = false;
			collidedObject = null;
		}
		
		public function onInteraction(InteractingObject : GameObject) :void {
			
		}
		public function removeObject():void {
			if (!removing) {
				removing = true;
				destroy();
				collider = false;
				dispatchEvent(new Event(REMOVED,true));
				parent.removeChild(this);
			}
		}
		public function destroy() :void {
			
		}
	}

}