package com.wheelerstreet.controllers
{	/**
 	* Controls the N images tacken at a time
 	* 
 	*/
 	import com.wheelerstreet.system.PhotoSaver;
 	import com.wheelerstreet.views.PhotoStrip;
 	
 	import flash.display.Bitmap;
 	import flash.display.BitmapData;
 	import flash.events.StatusEvent;
 	import flash.events.TimerEvent;
 	import flash.geom.Matrix;
 	import flash.media.Camera;
 	import flash.utils.Timer;
 	
 	import mx.containers.Canvas;
 	import mx.controls.Image;
 	import mx.controls.VideoDisplay;
 	 
 	

	public class SessionController extends ViewController
	{
		
		// file saver
		protected var _photoSaver:PhotoSaver;
		// camera and imaging objects		
		protected var _camera:Camera;
		protected var _cameraFlipperTimer:Timer;		
		protected var _bitmapData:BitmapData;
		// views 
		protected var _photoStrip:PhotoStrip;
		protected var _frame:Canvas;
		protected var _video:VideoDisplay;
		protected var _image:Image;
		
		public static var FPS:Number = 20;

		
		public function SessionController(photoStrip:PhotoStrip, frame:Canvas)
		{
			_photoStrip = photoStrip;
			_frame = frame;
			
			_photoSaver = new PhotoSaver("ednas");
			
		}
		
		override public function set active(value:Boolean):void
		{
			if(_active == value)
				return; 
				
			if(value) 
				start();
			else 
				stop();
			
			super.active = value;
		}
		
		override protected function start():void
		{	
			initVideoComponents();
			initUIComponents();
			_video.attachCamera(_camera);
			_photoSaver.startSession();
		}
		
		override protected function stop():void
		{
			destroyVideoComponents();
			_photoSaver.endSession();
		}
		
		protected function initUIComponents():void
		{
			var widthPadding:Number = 8;
			var heightPadding:Number = 8;
			_video = new VideoDisplay();
			_video.width = _frame.width-widthPadding;
			_video.height = _frame.height-heightPadding;
			
			_frame.addChild(_video);
			
			_image = new Image();
			_image.width = _frame.width-widthPadding;
			_image.height = _frame.height-heightPadding;
			
			_frame.addChild(_image);
			
		}
		
		protected function initVideoComponents():void
		{
			trace("Camera: "+Camera.names.length+" names: "+Camera.names);
			_camera = Camera.getCamera();
			_camera.setMode(_frame.width,_frame.height,FPS,true);
			_camera.setQuality(0,100);
			_camera.setMotionLevel(1);
			// camera flipper
			_cameraFlipperTimer = new Timer(1000/FPS);
			_cameraFlipperTimer.addEventListener(TimerEvent.TIMER, handleFlipperTimer,false,0,true);
			_cameraFlipperTimer.start();
		}
		
		private function statusHandler(event:StatusEvent):void {

            if (event.code == "Camera.Unmuted") {               	
                _camera.removeEventListener(StatusEvent.STATUS, statusHandler);
            }
        }
       
		public function additionalClick():void
		{
			
		}
		
		protected function handleFlipperTimer(e:TimerEvent):void
		{
			
			_bitmapData = new BitmapData(_video.width, _video.height, false, 0xFFFFFF);
			_bitmapData.draw(_video, new Matrix(-1,0,0,1,_video.width,0));
			var bitmap:Bitmap = new Bitmap(_bitmapData);
			_image.source = bitmap;
			
		}
		
		protected function destroyVideoComponents():void
		{
			
		}
		

	}
}