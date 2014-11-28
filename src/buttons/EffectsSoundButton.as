package buttons 
{
	import flash.events.MouseEvent;
	import soundTools.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EffectsSoundButton extends ToggleButton
	{
		public function EffectsSoundButton() :void{
			buttonArt = new SoundMuteButton();
		}
		override protected function toggleEvent(e:MouseEvent):void 
		{
			if (SoundManager.toggleMuteSound()) {
				buttonArt.gotoAndStop(1);
			}else {
				buttonArt.gotoAndStop(2);
			}
		}
		
	}

}