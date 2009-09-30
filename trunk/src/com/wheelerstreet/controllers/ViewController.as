package com.wheelerstreet.controllers
{
	import flash.events.EventDispatcher;
	
	public class ViewController extends EventDispatcher
	{
		public var _active:Boolean = false;
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
		
		protected function start():void
		{
			// 
		}
		
		protected function stop():void
		{
			//	
		}

	}
}