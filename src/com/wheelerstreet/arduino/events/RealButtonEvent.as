package com.wheelerstreet.arduino.events
{
	import flash.events.Event;

	public class RealButtonEvent extends Event
	{
		public static const BUTTON_STATE_UP:String = "buttonStateUp";
		public static const BUTTON_STATE_DOWN:String = "buttonStateDown";
		
		
		public function RealButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new RealButtonEvent(type,bubbles,cancelable);
		}
		
	}
}