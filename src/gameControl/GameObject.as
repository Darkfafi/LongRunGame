package gameControl 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
		private var removing : Boolean = false;
		public var collider : Boolean = true;
		
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
		
		public function onCollision(other : GameObject) :void {
			
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