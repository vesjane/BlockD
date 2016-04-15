package 
{
	/**
	 * ...
	 * @author Garonna
	 * 
	 */
	
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameWorld extends Sprite
	{
		
		public static const X_OFFSET:Number = 35;
		public static const Y_OFFSET:Number = 35;
		
		public static const GEM_WIDTH:Number = 32
		public static const GEM_HEIGHT:Number = 30;
		
		private var allgems:Vector.<Gem>;
		private var gempool:GemPool;
		private var contaner:Sprite;
		
		public function GameWorld() 
		{
			allgems = new Vector.<Gem>;
			allgems.length = InitGems.MAX_COLS * InitGems.MAX_ROWS;
			allgems.fixed = true;
			contaner = new Sprite();
			addChild(contaner);
			contaner.x = 60;
			contaner.y = 70;
			
			//init gemPool
			gempool = new GemPool(allgems.length);
			
			for (var n:int = 0; n < allgems.length; n++ )
			{
				gempool.addGem(new Gem());
			}
			
			for (var i:int = 0; i < InitGems.MAX_ROWS; i++ )
			{
				for (var j:int = 0; j < InitGems.MAX_COLS; j++ )
				{
					var g:Gem = gempool.getGem();
					putGemAtRowCol(g, i, j);
					//TODO::Дописать Listener  к гемам
					g.addEventListener(Gem.GEM_TOUCHED, gemTouched);
					
					g.x = X_OFFSET + j * GEM_WIDTH;
					g.y = Y_OFFSET + i * GEM_HEIGHT;
					
					contaner.addChild (g);
					
				}
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
				if (g.marked) removeGemFromRowCol(g.row, g.col);
			}
			//from left col to right most
			for (var n:int = 0; n < InitGems.MAX_COLS; n++)
			{
				//from bottom cell of each col to top
				EachRow: for (var m:int = InitGems.MAX_ROWS-1; m > -1; m--)
				{
					g = getGemAtRowCol(m, n);
					if (g) continue;
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
		
		private function removeGems():void
		{
			
		}
		
		private function findeSameGems(row:int, col:int):void
		{
			var idx:int = col + row * InitGems.MAX_COLS;
			allgems[idx].marked = true;
			//TODO:: дописать алгоритм поиска одинаковых гемов и маркировать их
			
			Starling.juggler.delayCall(gemsFillGaps, 0.8);
			Starling.juggler.delayCall(dropNewGems, 1.5);
			
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