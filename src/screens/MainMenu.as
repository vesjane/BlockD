package screens 
{
	import flash.text.Font;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * Класс главного меню игры
	 * @author Garonna
	 */
	public class MainMenu extends Sprite 
	{
		
		public var playButton:Sprite = new Sprite();
		private var btn2:Sprite = new Sprite();
		private var btn3:Sprite = new Sprite();
		private var btnFont:Font;
		
		[Embed(source = "/../res/Intro.otf",
		fontName = "Merge",
		mimeType = "application/x-font",
		fontWeight="Bold",
		fontStyle="Bold",
		advancedAntiAliasing = "true",
		embedAsCFF="false")]
		public static const fontMergeBold:Class;
		
		public function MainMenu() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var game:InitGems = InitGems.instance();
			btnFont = new fontMergeBold;
			
			
			var img:Image = new Image(game.getAssetMgr().getTexture("bg"));	
			addChild(img);
			
			var logo:Image = new Image(game.getAssetMgr().getTexture("brand"));                               
            logo.x = (stage.stageWidth - logo.width) / 2;
            logo.y = 20;
            addChild(logo);
			
			// контейнер для кнопок для удобного позиционирования этих кнопок
            var buttonsContainer:Sprite = new Sprite();
            addChild(buttonsContainer);
			
			playButton.addChild(new Image(game.getAssetMgr().getTexture("btn1")));
			var textField:TextField = new TextField(playButton.width,playButton.height,"Play",btnFont.fontName,32,0x475065);							
			playButton.addChild(textField);
			buttonsContainer.addChild(playButton);
			
			btn2.addChild(new Image(game.getAssetMgr().getTexture("btn2")));
			var textField2:TextField = new TextField(btn2.width,btn2.height,"ARCADE",btnFont.fontName,32,0x475065);							
			btn2.addChild(textField2);
			buttonsContainer.addChild(btn2);
			btn2.y = btn2.height + 20;
			addChild(buttonsContainer);
			
			
			
			btn3.addChild(new Image(game.getAssetMgr().getTexture("btn3")));
			var textField3:TextField = new TextField(btn3.width,btn3.height,"SETTINGS",btnFont.fontName,32,0x475065);							
			btn3.addChild(textField3);
			buttonsContainer.addChild(btn3);
			btn3.y = btn3.height*2 + 40;
			addChild(buttonsContainer);
			
			buttonsContainer.y = stage.height / 4 + playButton.height / 2;
			buttonsContainer.x = (stage.stageWidth - playButton.width) / 2;
			
			
		}
		
		
		private function initBtn():void
		{
			
		}
		
	}

}