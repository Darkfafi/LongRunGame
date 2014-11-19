package gameControl 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class GameObject extends Sprite
	{
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
		
		public function onCollide(other : GameObject) :void {
			
		}
	}

}