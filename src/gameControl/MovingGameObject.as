package gameControl 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MovingGameObject extends GameObject
	{
		protected var _speed : Number;
		protected var _dir : int;
		
		public function update():void 
		{
			movement();
		}
		
		public function movement() :void {
			if(_dir != 0){
				this.scaleX = _dir;
				this.x += _speed * _dir;
			}
		}
		
		public function get dir():int 
		{
			return _dir;
		}
		
		public function set dir(value:int):void 
		{
			_dir = value;
		}
		
	}

}