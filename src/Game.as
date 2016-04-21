package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import properties.GameEvent;
	import properties.ScreenType;
	import screens.MainMenu;
	import starling.display.Sprite;	
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.formatString;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Garonna
	 */
	public class Game extends Sprite 
	{		
        
		/** @private экран главного меню */
        private var menuScreen:MainMenu;
        /** @private экран игры */
        private var board:GameWorld;
		
		/** @private эта переменная хранит текстовое значения типа экрана 
                 * из constants.ScreenType, который отображается в данный момент 
                 * нужна для корректной очистки от слушателей и экранных объектов */
		private var currentScreen:String;
		
        public function Game()
        {
			super();            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);        
            
		}
		
		private function onAddedToStage(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            showMenu();
           // createGameBoard();
        }
		
		
		
		private function showMenu():void
		{
			currentScreen = ScreenType.MAIN_MENU;
			menuScreen = new MainMenu(); // создаём меню и добавляем его на сцену
            addChild(menuScreen);
			menuScreen.playButton.addEventListener(TouchEvent.TOUCH, startGame); 
		
		}
		 private function startGame(e:TouchEvent):void 
		 {
			
			var touch:Touch = e.getTouch(stage);
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				clear(); // очищаем
				currentScreen = ScreenType.GAME_SCREEN;			 
				board = new GameWorld();			
				addChild(board);
				board.addEventListener(GameEvent.EXIT_GAME, exitGame); 
			}
			 
		 }
		 
		 private function exitGame(e:GameEvent):void
		 {
            clear(); // очищаем
            showMenu(); // показываем главное меню
			
         }
		 
		  private function clear():void {
                        switch (currentScreen) {
                                case ScreenType.MAIN_MENU:
                                        menuScreen.playButton.removeEventListener(TouchEvent.TOUCH, startGame);
                                       // menuScreen.exitButton.removeEventListener(TouchEvent.TOUCH_TAP, deactivate);
                                        removeChild(menuScreen);
                                        menuScreen = null;
                                break;
                                
                                case ScreenType.GAME_SCREEN:
                                        //board.removeEventListener(GameEvent.EXIT_GAME, exitGame);
                                        //board.removeEventListener(GameEvent.GAME_OVER, gameOver);
                                        removeChild(board);
                                        board = null;
                                break;                                
                               
                        }
                }
		
				
			
		
		
	}
	
}