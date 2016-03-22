package 
{
	/**
	 * ...
	 * @author Garonna
	 * 
	 */
	import starling.display.Sprite;
	
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
					
					g.x = X_OFFSET + j * GEM_WIDTH;
					g.y = Y_OFFSET + i * GEM_HEIGHT;
					
					contaner.addChild (g);
					
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
		
	}

}