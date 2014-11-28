package 
{
	import buttons.EffectsSoundButton;
	import buttons.MusicSoundButton;
	import buttons.ToggleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.Game;
	import screens.Menu;
	import soundTools.SoundManager;
	
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
			SoundManager.loadSounds();
			addEventListener(Event.ENTER_FRAME, checkSoundsLoaded);
		}
		
		private function checkSoundsLoaded(e:Event):void 
		{
			if (SoundManager.allSoundsLoaded) {
				removeEventListener(Event.ENTER_FRAME, checkSoundsLoaded);
				placeButtons();
				switchScreen(MENU_SCREEN);
			}
		}
		
		private function placeButtons():void 
		{
			var soundButton : ToggleButton = new EffectsSoundButton()
			var musicButton : ToggleButton = new MusicSoundButton();
			soundButton.scaleX = 0.5;
			soundButton.scaleY = soundButton.scaleX;
			musicButton.scaleX = soundButton.scaleY;
			musicButton.scaleY = soundButton.scaleY;
			
			soundButton.x =	25;
			soundButton.y = 85;
			
			musicButton.x = soundButton.x;
			musicButton.y = soundButton.y + 50;
			stage.addChild(soundButton);
			stage.addChild(musicButton);
		}
		
		private function switchScreen(screen : String) :void {
			switch(screen) {
				case GAME_SCREEN:
					if (contains(menu)) {
						menu.destroy();
						removeChild(menu);
						menu = null;
						removeEventListener(Menu.START_GAME, startGame);
					}
					game = new Game();
					addChild(game);
					addEventListener(Game.BACK_TO_MENU, switchToMenu);
				break
				case MENU_SCREEN:
					if (contains(game)) {
						game.destroy();
						removeChild(game);
						game = null;
					}
					menu = new Menu();
					addChild(menu);
					addEventListener(Menu.START_GAME, startGame);
				break
				
			}
		}
		
		private function switchToMenu(e:Event):void 
		{
			switchScreen(MENU_SCREEN);
		}
		
		private function startGame(e:Event):void 
		{
			switchScreen(GAME_SCREEN);
		}
	}
	
}