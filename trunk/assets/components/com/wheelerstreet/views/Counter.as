package com.wheelerstreet.views
{
	import flash.text.TextField;
	import mx.flash.UIMovieClip;

	public class Counter extends UIMovieClip
	{
	
		
		public function Counter()
		{
			super();
		}
		
		public function set text(value:String):void
		{
			_textField.text = value;
		}
		
	}
}