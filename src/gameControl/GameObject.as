package gameControl 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		public var colliding : Boolean = false;
		public var collidedObject : GameObject;
		
		private var removing : Boolean = false;
		public var collider : Boolean = true;
		public var interActive : Boolean = false;
		
		public function GameObject() 
		{
			
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
			collidedObject = other;
		}
		
		public function onCollision(other : GameObject) :void {
			
		}
		
		public function onCollisionExit(other : GameObject):void {
			colliding = false;
			collidedObject = null;
		}
		
		public function onInteraction() :void {
			
		}
		public function removeObject():void {
			if (!removing) {
				removing = true;
				collider = false;
				parent.removeChild(this);
			}
		}
	}

}