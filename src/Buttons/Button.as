package Buttons 
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import com.greensock.TweenLite;
	import flash.events.TouchEvent;
	
	/**
	 * ...
	 * @author Garonna
	 */
	public class Button extends Sprite 
	{
		
		[Embed(source = "/../res/Intro.otf",
		fontName = "Merge",
		mimeType = "application/x-font",
		fontWeight="Bold",
		fontStyle="Bold",
		advancedAntiAliasing = "true",
		embedAsCFF="false")]
		public static const fontMergeBold:Class;
		
		
		private var btnFont:Font;
		private var txt:String;
		private var btnImg:Image;
	
		public function Button(text:String,img:Image) 
		{
			super();
			btnFont = new fontMergeBold;
			txt = text;
			btnImg = img;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
            removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			if (btnImg)
			{
				addChild(btnImg);
			}
			if (txt != "")
			{
				var txtField:TextField =  new TextField(this.width, this.height, txt, btnFont.fontName, 32, 0x475065);
				txtField.x = (btnImg.width - txtField.width) / 2;
                txtField.y = (btnImg.height - txtField.height) / 2;
				addChild(txtField);
			}
			
			this.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin); // прикосновение к кнопке
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage); // слушатель удаления со stage
                
		}
		
		 private function touchBegin(e:TouchEvent):void 
		 {
            TweenLite.to(btnImg, .3, { alpha:.5 } );
            stage.addEventListener(TouchEvent.TOUCH_END, touchEnd); // убирание пальца от дисплея после прикосновения к кнопке
		 }
		
		  private function touchEnd(e:TouchEvent):void 
		  {
             TweenLite.to(btnImg, .3, { alpha:1 } );
             stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd)
          }
		  
		  private function removedFromStage(e:Event):void 
		  {
             removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
             this.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
             stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd)
          }
                
		
		
	}

}