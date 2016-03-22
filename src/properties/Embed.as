package properties 
{

	/**
	 * ...
	 * @author Garonna
	 */
	public class Embed 
	{
		
		public function Embed()
		{
		}
		
		[Embed (source="/../res/1.png" )]
		public static const Gem1:Class;		

		[Embed (source="/../res/2.png" )]
		public static const Gem2:Class;		

		[Embed (source="/../res/3.png" )]
		public static const Gem3:Class;
		
		[Embed (source="/../res/bg.jpg" )]
		public static const bg:Class;

		
	}

}