package com.wheelerstreet.controllers
{
	import com.wheelerstreet.arduino.events.RealButtonEvent;
	import com.wheelerstreet.arduino.serial.SerialConnection;
	import com.wheelerstreet.events.ArduinoButtonEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;


	[Event(name="buttonUp", type="com.wheelerstreet.events.ArduinoButtonEvent")]

	[Event(name="buttonDown", type="com.wheelerstreet.events.ArduinoButtonEvent")]

	public class ArduinoController extends EventDispatcher
	{
		
		
		protected var _serialConnection:SerialConnection;
		
		public function ArduinoController(target:IEventDispatcher=null)
		{
			_serialConnection = new SerialConnection();
			_serialConnection.addEventListener(RealButtonEvent.BUTTON_STATE_DOWN, handleButtonStateDown);
			_serialConnection.addEventListener(RealButtonEvent.BUTTON_STATE_UP, handleButtonStateUp);
		}
		
		protected function handleButtonStateDown(e:RealButtonEvent):void
		{
			trace("down: ");
			dispatchEvent(new ArduinoButtonEvent(ArduinoButtonEvent.BUTTON_DOWN));
		}
		
		protected function handleButtonStateUp(e:RealButtonEvent):void
		{
			trace("up: ");
			dispatchEvent(new ArduinoButtonEvent(ArduinoButtonEvent.BUTTON_UP));
		}
		
	}
}