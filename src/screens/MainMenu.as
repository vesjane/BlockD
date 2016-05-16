package screens 
{
	import Buttons.Button;
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
		
		public var playButton:Button;
		private var btn2:Button;
		private var btn3:Button;			
		
		public function MainMenu() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var game:InitGems = InitGems.instance();			
			
			
			var img:Image = new Image(game.getAssetMgr().getTexture("bg"));	
			addChild(img);
			
			var logo:Image = new Image(game.getAssetMgr().getTexture("brand"));                               
            logo.x = (stage.stageWidth - logo.width) / 2;
            logo.y = 20;
            addChild(logo);
			
			// контейнер для кнопок для удобного позиционирования этих кнопок
            var buttonsContainer:Sprite = new Sprite();
            addChild(buttonsContainer);
			
			playButton = new Button("Play",new Image(game.getAssetMgr().getTexture("btn1")));			
			buttonsContainer.addChild(playButton);
			
			btn2 = new Button("ARCADE", new Image(game.getAssetMgr().getTexture("btn2")));		
			buttonsContainer.addChild(btn2);
			btn2.y = btn2.height + 20;
			addChild(buttonsContainer);			
			
			
			btn3= new Button("SETTINGS",new Image(game.getAssetMgr().getTexture("btn3")));			
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