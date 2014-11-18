package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.Game;
	import screens.Menu;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{
		public static const  MENU_SCREEN : String = "menuScreen";
		public static const  GAME_SCREEN : String = "gameScreen";
		
		private var menu : Menu = new Menu();
		private var game : Game = new Game();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			switchScreen(GAME_SCREEN);
		}
		
		private function switchScreen(screen : String) :void {
			switch(screen) {
				case GAME_SCREEN:
					if (contains(menu)) {
						menu.destroy();
						removeChild(menu);
						menu = null;
					}
					game = new Game();
					addChild(game);
				break
				case MENU_SCREEN:
					if (contains(game)) {
						game.destroy();
						removeChild(game);
						game = null;
					}
					menu = new Menu();
					addChild(menu);
				break
				
			}
		}
	}
	
}