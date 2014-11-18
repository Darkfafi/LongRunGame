package gameControl 
{
	import game.mainObjects.Player;
	import placeholderAssets.BackGround;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class CollisionSystem 
	{
		public function checkCollision(listObjects : Array, player : Player, background : BackGround) :void {
			if (player.x <= (background.x - background.width / 2) + player.width / 1.5 && player.dir == -1) {
				player.dir = 0;
			}else if (player.x >= (background.x + background.width / 2) - player.width / 1.5 && player.dir == 1) {
				player.dir = 0;
			}
			var l : int = listObjects.length;
			for (var i : int = l - 1; i >= 0; i--) {
				if (listObjects[i] is Player) {
					var player : Player = listObjects[i];
				}
			}
		}
	}

}