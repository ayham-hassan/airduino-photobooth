package com.wheelerstreet.views
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import mx.events.FlexEvent;
	import mx.flash.UIMovieClip;
	
	public class PhotoStrip extends UIMovieClip
	{
		protected var currentPhoto:uint = 0;
		protected static const MAX_PHOTOS:Number = 4;
		protected var _mc:MovieClip;
		
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
		
		public  function addThumb(bitmap:Bitmap):void
		{
			bitmap.name = "bitmap";
			var photo:Photo;
			
			if(currentPhoto >= MAX_PHOTOS) {
				// reset				
				currentPhoto = 0;				
				clearBitmapWithId(currentPhoto.toString());
			}
			photo = getPhoto(currentPhoto.toString());
			
			
			photo.addChild(bitmap);
			currentPhoto++;
		}
		
		protected function getPhoto(pid:String):Photo
		{
			try {
				return this["photo_"+pid];
			} catch(e:Error) {
				trace(" could not find photo_"+id);
			}
			return null;
		}
		
		protected function clearBitmapWithId(pid:String):void
		{
			var photo:Photo = getPhoto(pid);
			photo.removeChild(photo.getChildByName("bitmap"));	
		}
		
		protected function clearAll():void
		{
			
			for(var i:uint=0; i < MAX_PHOTOS; i++) {				
				clearBitmapWithId(i.toString());
			}
			
			currentPhoto = 0;
		}
		
	}
}