package 
{
	/**
	 * ...
	 * @author Garonna
	 * 
	 */
	
	import Buttons.Button;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.utils.Timer;
	import properties.GameEvent;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.events.TimerEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class GameWorld extends Sprite
	{
		
		
		
		public static const X_OFFSET:Number = 0;
		public static const Y_OFFSET:Number = 50;
		
		public static const GEM_WIDTH:Number = 41;
		public static const GEM_HEIGHT:Number = 42;
		
		private var allgems:Vector.<Gem>;
		private var gempool:GemPool;
		private var contaner:Sprite;
		
		/** @private тип выбранной игры( бесконечная или на время) */
		private var isTimeGame:Boolean = true;
		/** @private первое касание для запуска таймера */
		private var isGameStart:Boolean = false;
		
		
		private var _stWidth:int;
		private var _stHeight:int;
		
		/** @private кнопка для выхода в главное меню */
        private var menuButton:Button;
		/** @private игровой таймер. нужен для добавления нового айтема */
        private var gameTimer:Timer;
        /** @private номер текущего уровня */
        private var currentLevel:uint;
        /** @private текущее количество очков */
        private var currentScore:int = 0;
		 /** @private необходимо количество очков */
        private var maxScore:int = 8000;
        /** @private текстовое поле для отображения номера уровня */
        private var levelText:TextField;
        /** @private текстовое поле для отображения очков */
         private var scoreText:TextField;
		 
		 /** @private текстовое поле для отображения времени */
        private var timerText:TextField;
		 /** @private Стартовое значение таймера */
		public var levelDuration:int = 60;
		public var gameTime:int;
		
		 
		 /** @private количество очков за 1 гем */
		private var gemScore:Number = 10;
		
		 
		[Embed(source = "/../res/Intro.otf",
		fontName = "Merge",
		mimeType = "application/x-font",
		fontWeight="Bold",
		fontStyle="Bold",
		advancedAntiAliasing = "true",
		embedAsCFF="false")]
		public static const fontMergeBold:Class;
		
		
		private var btnFont:Font;
		
		
		public function GameWorld() 
		{
			 addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
	private function onAddedToStage(e:Event):void {
           
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			contaner = new Sprite();
			btnFont = new fontMergeBold;
			
			var game:InitGems = InitGems.instance();
			var img:Image = new Image(game.getAssetMgr().getTexture("bg"));	
			addChild(img);
			
			//timer init
			gameTimer = new Timer(1000,levelDuration);
			gameTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timeExpired);
			gameTime = levelDuration;
			
			
			//верхнее меню ------------------------
			timerText = new TextField(100, 30, "90", btnFont.fontName, 32, 0xFFFFFF);
			addChild(timerText);
			timerText.x = 8
			timerText.y = 20;
			timerText.text = levelDuration.toString();
			
			scoreText = new TextField(this.width/4, 30, currentScore.toString(), btnFont.fontName, 32, 0xFFFFFF);
			addChild(scoreText);
			scoreText.x = (4+GEM_WIDTH)*InitGems.MAX_COLS / 2 - scoreText.width / 2;		
			scoreText.y = 20;
					
			menuButton = new Button("",new Image(game.getAssetMgr().getTexture("pause")));	
			addChild(menuButton);
			menuButton.x = (4+GEM_WIDTH)*InitGems.MAX_COLS - menuButton.width;
			menuButton.y = 20;
			menuButton.addEventListener(TouchEvent.TOUCH, exitGame); // событие нажатия на кнопку выхода в меню
			
			addChild(menuButton);
			//-----------------------------------           
			initGems();            
        }
		
		
		private function initGems():void 
		{
			
			allgems = new Vector.<Gem>;
			allgems.length = InitGems.MAX_COLS * InitGems.MAX_ROWS;
			allgems.fixed = true;			
			//init gemPool
			gempool = new GemPool(allgems.length);
			
			for (var n:int = 0; n < allgems.length; n++ )
			{
				gempool.addGem(new Gem());
			}
			
			for (var i:int = InitGems.MAX_ROWS-1; i >= 0;  i-- )
			{
				for (var j:int = InitGems.MAX_COLS-1; j >= 0;  j-- )
				{
					var g:Gem = gempool.getGem();					
					putGemAtRowCol(g, i, j);
					//TODO::Дописать Listener  к гемам
					g.addEventListener(Gem.GEM_TOUCHED, gemTouched);
					
					g.x = X_OFFSET + j * GEM_WIDTH;
					g.y = Y_OFFSET + i * GEM_HEIGHT;					
					
					addChild (g);				
					
				}
			}
		}
		
		private function clearBoard():void
		{
			for (var i:int = 0; i < InitGems.MAX_COLS; i++ )
			{
				for (var j:int = 0; j < InitGems.MAX_ROWS; j++ )
				{
					putGemAtRowCol(null, j, i);
					
				}
			}
			gempool = null;
			
		}
		
		
		
		private function nextLvl():void
		{
			
		}
		
		public function timerHandler(event:TimerEvent):void 
		{
			if(gameTime > 0)
				gameTime--;
			timerText.text = gameTime.toString();
            
        }
		
		
		public function  timeExpired(event:TimerEvent):void 
		{
            
        }
		
		private function calculateScore(count:int):void
		{
			if (count > 5 && count < 10)
			{
				currentScore = currentScore + (count * gemScore)*1.5;
			}
			if (count >= 10 && count < 20)
			{
				currentScore = currentScore + (count * gemScore)*2;
			}
			if (count >= 20)
			{
				currentScore = currentScore + (count * gemScore)*2.5;
			}
			else
			{
				currentScore = currentScore + count * gemScore;
			}
			
			scoreText.text = currentScore.toString();
			
		}
		
		
		private function exitGame(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				
                dispatchEvent(new GameEvent(GameEvent.EXIT_GAME));
			}
        }
		
		private function gemTouched(e:Event):void
		{
			if (!isGameStart)
			{
				gameTimer.start();
				isGameStart = true;
			}
			var gem:Gem = e.target as Gem;				
			findeSameGems(gem.row, gem.col);
			
		}
		
		
		private function gemsFillGaps():void
		{
			var gemCounter:Number = 0;
			for each (var g:Gem in allgems)
			{
				if (g && g.marked)
				{
					removeGemFromRowCol(g.row, g.col);
					gemCounter ++;
				}
				
			}			
			
			//from left col to right most
			for (var n:int = 0; n < InitGems.MAX_COLS; n++)
			{
				//from bottom cell of each col to top
				EachRow: for (var m:int = InitGems.MAX_ROWS-1; m > -1; m--)
				{							
					
						g = getGemAtRowCol(m, n);
						if (g)
						{							
							continue;
						}
						else
						{
							
							//search for a gem in the above rows, when found bring it down
							//if nothing found until top, then fill all of them with new gems
							for (var o:int = m - 1; o > -1; o--)
							{
								var sg:Gem = getGemAtRowCol(o, n);
								if (sg)
								{
									//remove gem from current position, assign new position
									//make it move
									
									putGemAtRowCol(sg, m, n, o, n);
									moveGemToLocation(sg, m, n);
									continue EachRow;
								}								
							}
								
								if (o == -1)
								break EachRow;
						}
					
				}
			
			
			}	
			calculateScore(gemCounter);
			gemCounter = 0;		
			
		}
		
		
		private function isEmptyCol(col:int):Boolean
		{
			
			var count:int = 0;
			//from top row to bottom 
			for (var n:int = col; n > -1; n--)
			{
				for (var i:int = 0; i < InitGems.MAX_ROWS; i++ )
					{
						var g:Gem = getGemAtRowCol(i, col);
						if (g)
						{							
							continue;
						}
						else
							count++; 
					}
					if (count == InitGems.MAX_ROWS)
					{
						return true
					}
					count = 0;
			
			}	
			
			return false;
		}

		
		private function gemsFillColGaps():void
		{
			var gapCounter:int = 1;
			for (var n:int = 0; n < InitGems.MAX_COLS; n++)
			{
				EachCol:for (var c:int = InitGems.MAX_COLS - 1; c > -1; c--)
				{
					if (isEmptyCol(c))
					{						
						for (var r:int = InitGems.MAX_ROWS - 1; r > -1; r--)
							{
								var sg:Gem = getGemAtRowCol(r, c-gapCounter);
								if (sg)
								{
									putGemAtRowCol(sg, r, c, r, c-gapCounter);
									moveGemToLocation(sg, r, c);	
																				
										
								} 
							}
					}
					else
					{						
						continue EachCol;
					}								
				
			}
			}
			
		}
	
		
						
		
		private function markGems(arr:Vector.<Gem>):void
		{
			var idx1:int;
			var idx2:int;
			var idx3:int; 
			var idx4:int; 
			var idx5:int;
			
			var tmpArr:Vector.<Gem> = new Vector.<Gem>;
			var count:int = 0;		
			
			
			for (var i:int  = 0; i <  arr.length; i++ )
			{
				if (arr[i].col + 1 < InitGems.MAX_COLS)
				{
					idx2 = arr[i].col + 1 + arr[i].row * InitGems.MAX_COLS;
				}
				if (arr[i].col - 1  >= 0 )
				{
					 idx3 = arr[i].col - 1 + arr[i].row * InitGems.MAX_COLS;
				}
				 
				
				if (arr[i].row + 1 < InitGems.MAX_ROWS)
				{
				
				 idx4 = arr[i].col + (arr[i].row + 1) * InitGems.MAX_COLS;
				}
				if (arr[i].row - 1 >= 0 )
				{				
				 idx5 = arr[i].col + (arr[i].row - 1) * InitGems.MAX_COLS;
				}
				
				//----------------------------------------
			
				
				if (allgems[idx2]&& arr[i].col + 1 < InitGems.MAX_COLS && arr[i].gemType == allgems[idx2].gemType && allgems[idx2].marked!= true)
				{	
					allgems[idx2].marked = true;
					allgems[idx2].visible = false;
					tmpArr[count] = allgems[idx2]as Gem;
					count++;
				}
				if ( allgems[idx3]&& arr[i].col - 1  >= 0 && arr[i].gemType == allgems[idx3].gemType && allgems[idx3].marked!= true)
				{
					
					allgems[idx3].marked = true;
					tmpArr[count] = allgems[idx3] as Gem;
					allgems[idx3].visible = false;
					count ++;
				}
				
				if ( allgems[idx4]&& arr[i].row + 1 < InitGems.MAX_ROWS && arr[i].gemType == allgems[idx4].gemType && allgems[idx4].marked!= true)
				{
					
					allgems[idx4].marked = true;
					tmpArr[count] = allgems[idx4]as Gem;
					allgems[idx4].visible = false;
					count++;
				}
				if (allgems[idx5]&& arr[i].row - 1 >= 0 && arr[i].gemType == allgems[idx5].gemType && allgems[idx5].marked!= true)
				{
					
					allgems[idx5].marked = true;
					allgems[idx5].visible = false;
					tmpArr[count] = allgems[idx5]as Gem;
					count++;
				}
			
			}
			
			if (tmpArr.length > 0)
			{			
				count = 0;				
				markGems(tmpArr);
			}
		}
		
		private function findeSameGems(row:int, col:int):void
		{
			var idx:int = col + row * InitGems.MAX_COLS;
			var tmpArr:Vector.<Gem> = new Vector.<Gem>;
			//allgems[idx].marked = true;			
			tmpArr[0] = allgems[idx]; 
			
			//TODO:: оптимизировать и исправить алгоритм поиска одинаковых гемов и маркировать их
			if(tmpArr && tmpArr.length>0)
				markGems(tmpArr);
			
			
			Starling.juggler.delayCall(gemsFillGaps, 0.1);
			Starling.juggler.delayCall(gemsFillColGaps, 0.2);			
			if(!isTimeGame)
				Starling.juggler.delayCall(dropNewGems, 0.3);
			
		}
		
		private function dropNewGems():void
		{		
			//from left col to right most
			for (var n:int = 0; n < InitGems.MAX_COLS; n++)
			{
				var gapStarted:Boolean = false;
				
				//from bottom cell of each col to top
				for (var m:int = InitGems.MAX_ROWS-1; m > -1; m--)
				{
					if (!gapStarted)
					{
						if (getGemAtRowCol(m, n)) 
							continue;
						
						gapStarted = true;
					}
				
					var newgem:Gem = gempool.getGem();
					newgem.revive();
					putGemAtRowCol(newgem, m, n);
					
					//now make gem fall from top to down
					var p:Point = locationForRowCol(m, n);
					newgem.x = p.x;
					newgem.y = p.y - (InitGems.MAX_ROWS-2) * GEM_HEIGHT;
					moveGemToLocation(newgem, m, n);
					newgem.visible = true;
				}
			}
		}
		
		private function putGemAtRowCol(g:Gem, row:int, col:int, fromrow:int = -1, fromcol:int = -1):void
		{
			if (g)
			{
				g.row = row;
				g.col = col;
			}
			
			if (fromrow != -1 && fromcol != -1)
				allgems[fromcol + fromrow * InitGems.MAX_COLS] = null;
			
			allgems[col + row * InitGems.MAX_COLS] = g;
			
		}
		
		private function getGemAtRowCol(row:int, col:int):Gem
		{
			var idx:int = col + row * InitGems.MAX_COLS;
			if (row < 0 || col < 0 || row > InitGems.MAX_ROWS - 1 || col > InitGems.MAX_COLS - 1) return null;
			
			return	(allgems[idx]) as Gem;
				
		}
		
		private function moveGemToLocation(g:Gem, row:int, col:int, userInited:Boolean = false):void
		{
			g.moveTo(
				X_OFFSET + col * GEM_WIDTH, 
				Y_OFFSET + row * GEM_HEIGHT, userInited);
		}
		
		private function removeGemFromRowCol(row:int, col:int):void
		{
			
			gempool.addGem(getGemAtRowCol(row, col));
			putGemAtRowCol(null, row, col);
		}
		
		private function locationForRowCol(row:int, col:int):Point
		{
			var p:Point = new Point();
			p.x = X_OFFSET + col * GEM_WIDTH;
			p.y = Y_OFFSET + row * GEM_HEIGHT;
			
			return p;
		}
		
		
	}

}