package com.wheelerstreet.system
{
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class PhotoSaver extends EventDispatcher
	{
	
		public static var NUM_IMAGES:Number = 4;
		public static var ROOT_FOLDER:String = "PhotoBooth";
		public static var FOLDER_PREFIX:String = "set_";
		public static var FILE_PREFIX:String = "photo_";
		
		protected var _prefix:String;
		protected var _currentFolder:File;
		protected var _currentFile:File;	
		protected var _currentCount:Number = 0;
		
		protected var _byteArray:ByteArray;
		
		public function PhotoSaver(prefix:String)
		{
			if(prefix)
				_prefix = prefix;
			else 
				_prefix = FOLDER_PREFIX;	
			
			
				
		}
		
		protected function getTimeStamp():String
		{
			var date:Date = new Date();
			return date.getTime().toString();
		}
		
		protected function createRootFolder():void
		{
			var path:String = ROOT_FOLDER;
			trace("making ROOT folder: "+path);			
			var dir:File = File.desktopDirectory.resolvePath(path);
			if(dir.exists)
				return;
			else 
				dir.createDirectory();
		}
		
		protected function createNewSessionFolder():File
		{
			var path:String = ROOT_FOLDER + "/" + FOLDER_PREFIX + getTimeStamp();
			trace("making folder: "+path);			
			var dir:File = File.desktopDirectory.resolvePath(path);
			if(!dir.exists)
				dir.createDirectory();
			return dir;			
		}
		
		public function startSession():void
		{
			createRootFolder();
			
			_currentCount = 0;			
			_currentFolder = createNewSessionFolder();
		}
		
		
		public function saveImage(bitmapData:BitmapData):void
		{
			if(_byteArray) {
				_byteArray = null;
			}
			
			_byteArray = PNGEncoder.encode(bitmapData);
			var path:String = _currentFolder+File.separator+FILE_PREFIX+"_"+_currentCount.toString()+".png";
			trace("making new file: "+path);
			var newImage:File = File.desktopDirectory.resolvePath(path);
			var fileStream:FileStream = new FileStream();
			fileStream.open(newImage,FileMode.WRITE);
			fileStream.writeBytes(_byteArray);
			fileStream.close();
			
			_currentCount++;
				
		}
		
		public function endSession():void
		{
			_currentFile = null;
			_currentFolder = null;
		}
		
	}
}