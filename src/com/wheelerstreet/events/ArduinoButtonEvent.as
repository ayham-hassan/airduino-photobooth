package com.wheelerstreet.events
{
	import flash.events.Event;

	public class ArduinoButtonEvent extends Event
	{
		
		public static const BUTTON_UP:String = "buttonUp";
		public static const BUTTON_DOWN:String = "buttonDown";
		
		public function ArduinoButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}