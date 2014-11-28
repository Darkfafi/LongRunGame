package buttons 
{
	import events.HudEvent;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class PauseButton extends ToggleButton
	{
		private var paused : int = 0;
		public static const PAUSE_PRESSED : String = "pausePressed";
		
		public function PauseButton() 
		{
			buttonArt = new PlayToggleButton();
		}
		
		override protected function toggleEvent(e:MouseEvent):void 
		{			
			var event : HudEvent;
			paused == 1 ? 0 : 1;
			event = new HudEvent(PAUSE_PRESSED, paused, true);
			if (!paused) {
				buttonArt.gotoAndStop(1);
			}else {
				buttonArt.gotoAndStop(2);
			}
			dispatchEvent(event);
		}
	}

}