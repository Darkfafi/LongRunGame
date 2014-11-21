package gameControl 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		public static const ADDED : String = "added";
		public static const REMOVED : String = "removed";
		
		public var info : int;
		
		public var colliding : Boolean = false;
		public var collidedObject : GameObject;
		
		private var removing : Boolean = false;
		
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
			parent.dispatchEvent(new Event(ADDED));
		}
		
		public function willCollide(other : GameObject) : Boolean {
			var result : Boolean = false;
			if (this.hitTestObject(other)) {
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
				collider = false;
				parent.dispatchEvent(new Event(REMOVED));
				parent.removeChild(this);
			}
		}
	}

}