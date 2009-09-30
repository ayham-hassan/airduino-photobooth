package com.wheelerstreet.arduino.serial
{
	import com.wheelerstreet.arduino.events.RealButtonEvent;
	
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="buttonStateUp",type="com.wheelerstreet.ardunio.events.RealButtonEvent")]
	
	[Event(name="buttonStateDown",type="com.wheelerstreet.ardunio.events.RealButtonEvent")]

	public class SerialConnection extends EventDispatcher
	{
	
		protected var sensorData:String = "";
		protected static var LOCALHOST:String = "127.0.0.1";
		protected static var PORT:Number = 5331;
		protected static var BUTTON_DOWN:String = "red_button_0";
		protected static var BUTTON_UP:String = "red_button_1";
		
		protected var serialPort:SerialPort;
		
		public function SerialConnection(target:IEventDispatcher=null)
		{
			super(target);
			serialPort = new SerialPort();
			serialPort.addEventListener(DataEvent.DATA, onArduinoData );
			serialPort.connect(LOCALHOST,PORT);
		}
		
		protected function onArduinoData( event:DataEvent ):void
		{
			// trace( "onArduinoData", event.data );
			// add to sensor data
			sensorData = sensorData + event.data;
			// if it finds newline the packet of sensor data is done
			if (sensorData.indexOf("\n") > 0 ) {
				// process sensor data
				var dataWithoutNewline:String = sensorData.slice(0,-2);
		
				// trace("read: "+dataWithoutNewline);
				if(BUTTON_UP == dataWithoutNewline) {
					//quad1.alpha = .3;
					dispatchEvent(new RealButtonEvent(RealButtonEvent.BUTTON_STATE_UP));
				}
				if(BUTTON_DOWN == dataWithoutNewline) {
					//quad1.alpha = 1;
					dispatchEvent(new RealButtonEvent(RealButtonEvent.BUTTON_STATE_DOWN));
				}
				
				sensorData = "";
			}
		}

		
	}
}