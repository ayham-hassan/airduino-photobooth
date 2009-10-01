package com.wheelerstreet.system
{
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	[Event(name="complete",type="flash.events.Event")]
	
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
		
		protected var _savingFile:Boolean;
		
		public function PhotoSaver(prefix:String)
		{
			if(prefix)
				_prefix = prefix;
			else 
				_prefix = FOLDER_PREFIX;	
			
			_savingFile = false;
		}
		
		protected function getTimeStamp():String
		{
			var date:Date = new Date();
			return date.getTime().toString();
		}
		
		protected function createRootFolder():void
		{
			var path:String = ROOT_FOLDER.toString();
			trace("making ROOT folder: "+path);			
			var dir:File = File.desktopDirectory.resolvePath(path);
			if(dir.exists)
				return;
			else 
				dir.createDirectory();
		}
		
		protected function createNewSessionFolder():File
		{
			var path:String = ROOT_FOLDER.toString() + "/" + FOLDER_PREFIX + getTimeStamp();
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
			
			if(_savingFile) {
				// don't let the user try to save a file while busy	
				return;
			}
			_savingFile = true;
			
			_byteArray = PNGEncoder.encode(bitmapData);
			var path:String = _currentFolder.nativePath+File.separator+_prefix+"_"+_currentCount.toString()+".png";
			trace("making new file: "+path);
			var newImage:File = File.desktopDirectory.resolvePath(path);
			var fileStream:FileStream = new FileStream();
			fileStream.open(newImage,FileMode.WRITE);
			fileStream.writeBytes(_byteArray);
			fileStream.close();
			_currentCount++;
			_savingFile = false;
			dispatchEvent(new Event(Event.COMPLETE,false,false));
		}
		
		public function endSession():void
		{
			_currentFile = null;
			_currentFolder = null;
		}
		
	}
}