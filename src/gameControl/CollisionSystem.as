package gameControl 
{
	import flash.display.DisplayObjectContainer;
	import game.mainObjects.Bullet;
	import game.mainObjects.Player;
	import placeholderAssets.BackGround;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CollisionSystem 
	{
		public function checkCollision(listObjects : Array,world : DisplayObjectContainer, player : Player, background : BackGround) :void {
			if (player.x <= (background.x - background.width / 2) + player.width / 1.5 && player.dir == -1) {
				player.dir = 0;
			}else if (player.x >= (background.x + background.width / 2) - player.width / 1.5 && player.dir == 1) {
				player.dir = 0;
			}
			var l : int = listObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				if (listObjects[i] is Bullet) {
					var bullet : Bullet = listObjects[i] as Bullet;
					if (bullet.y > background.height) {
						world.removeChild(bullet);
					}
				}
			}
		}
	}

}