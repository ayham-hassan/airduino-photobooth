package com.wheelerstreet.views
{
	
	import mx.flash.UIMovieClip;

	public class RedButton extends UIMovieClip
	{
		
		public static const UP:String = "_up";
		public static const DOWN:String = "_down";
		
		public function RedButton()
		{
			super();
		}
		
		public function set state(value:String):void
		{
			if(value == UP || value == DOWN)
				gotoAndStop(value); 
		}
		
	}
}