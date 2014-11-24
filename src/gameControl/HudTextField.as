package gameControl 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HudTextField extends GameObject 
	{
		private var format : TextFormat = new TextFormat("impact");
		private var textField : TextField = new TextField();
		
		public function HudTextField(text : String = "", size : int = 20,color : uint = 0x000000) 
		{
			super();
			collider = false;
			format.size = size;
			textField.defaultTextFormat = format;
			textField.multiline = true;
			textField.selectable = false;
			textField.width = 250;
			textField.text = text;
			addChild(textField);
		}
		
		public function changeText(text : String) :void {
			textField.htmlText = text;
		}
		public function changeColor(color : uint) :void{
			format.color = color;
			textField.setTextFormat(format);
		}
		public function changeSize(size : int) :void{
			format.size = size;
			textField.setTextFormat(format);
		}
	}

}