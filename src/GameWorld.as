package 
{
	/**
	 * ...
	 * @author Garonna
	 * 
	 */
	
	import flash.geom.Point;
	import properties.GameEvent;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameWorld extends Sprite
	{
		
		
		
		public static const X_OFFSET:Number = 0;
		public static const Y_OFFSET:Number = 50;
		
		public static const GEM_WIDTH:Number = 41;
		public static const GEM_HEIGHT:Number = 42;
		
		
		private var menuButton:Sprite;
		
		private var allgems:Vector.<Gem>;
		private var gempool:GemPool;
		private var contaner:Sprite;
		
		private var isTimeGame:Boolean = true;
		
		
		private var _stWidth:int;
		private var _stHeight:int;
		
		public function GameWorld() 
		{
			 addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
	private function onAddedToStage(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var game:InitGems = InitGems.instance();
			var img:Image = new Image(game.getAssetMgr().getTexture("bg"));			
			addChild(img);
			
			menuButton = new Sprite();
			menuButton.addChild(new Image(game.getAssetMgr().getTexture("menuBack")));
			addChild(menuButton);
			menuButton.x = stage.width/1.5 + menuButton.width/2;
			menuButton.y = 10;
			 menuButton.addEventListener(TouchEvent.TOUCH, exitGame); // событие нажатия на кнопку выхода в меню
			
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
			var gem:Gem = e.target as Gem;				
			findeSameGems(gem.row, gem.col);
			
		}
		
		
		private function gemsFillGaps():void
		{
			for each (var g:Gem in allgems)
			{
				if (g && g.marked) removeGemFromRowCol(g.row, g.col);
			}
			
			
			//TODO:Не работает! Дописать сдвиг столбцов!!!!!
			//columnFillGaps();
			
			
			var count:int = 0;
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
			
			

			
		}
		
		private function isEmtyColumn(col:int):Boolean
		{
			var count:int = 0;
			for (var o:int = InitGems.MAX_ROWS-1; o > -1; o--)
			{
				var sg:Gem = getGemAtRowCol(o, col);
				if (sg)
				{
					continue;
				}
				else
				{
					count++;
				}
								
			}
			if (count == InitGems.MAX_ROWS - 1 )
			{
				return true				
								
			} 
			else
			{
				return false;
			}
			
		}
		
		
		private function columnFillGaps():void
		{
			for (var n:int = 0; n < InitGems.MAX_COLS; n++)
			{
			
				if (isEmtyColumn(n))
				{
					EachCol: for (var c:int = n-1; c > -1; c--)
					{
						if (!isEmtyColumn(c))
						{
							for (var o:int = InitGems.MAX_ROWS - 1; o > -1; o--)
							{
								var sg:Gem = getGemAtRowCol(o,c);
								if (sg)
								{
									putGemAtRowCol(sg,o,n,o,c);
									moveGemToLocation(sg, o, n);
									continue EachCol;
													
								}
								if (o == -1)
								break EachCol;	
										
							}
						}
								
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