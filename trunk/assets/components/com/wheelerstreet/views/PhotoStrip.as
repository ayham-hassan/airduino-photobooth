package com.wheelerstreet.views
{
	import flash.display.MovieClip;
	
	import mx.events.FlexEvent;
	import mx.flash.UIMovieClip;
	
	public class PhotoStrip extends UIMovieClip
	{
		public function PhotoStrip()
		{
			
			addEventListener(FlexEvent.CREATION_COMPLETE, handleComplete);
		}
		
		protected function handleComplete(e:FlexEvent):void
		{
			initPhotos();
		}
		
		protected function initPhotos():void
		{
			Photo(photo_0).textField.text = "1";
			Photo(photo_1).textField.text = "2";
			Photo(photo_2).textField.text = "3";
			Photo(photo_3).textField.text = "4";
		}
	}
}