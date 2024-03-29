// AS3 version of the SerialPort class
// originally written by Massimo Banzi @ Tinker.it based on
// code by Beltran Berrocal @ Progetto2501.it
//
// Ported to AS3 by Tink (Stephen Downs)
//
// Version 0.3 11.01.2007
//



package com.wheelerstreet.arduino.serial
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.Endian;

	public class SerialPort extends EventDispatcher
	{
		
		private var _host		: String;
		private var _socket		: Socket;
		
		
		public function SerialPort( host:String = null, port:int = 0 )
		{
			super();
			
			_socket = new Socket();
			
			_socket.addEventListener( Event.CLOSE, onClose );
			_socket.addEventListener( Event.CONNECT, onConnect );
			_socket.addEventListener( IOErrorEvent.IO_ERROR, onIOErrorEvent );
			_socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_socket.addEventListener( ProgressEvent.SOCKET_DATA, onSocketData );
		}
		
		
		public function get connected():Boolean
		{
			return _socket.connected;
		}
		
		public function close():void
		{
			_socket.close();
		}
		
		public function connect( host:String = null, port:int = 0 ):void
		{			
			_socket.connect( host, port );
			
			trace( "SerialPort: connecting" );
		}
		
		public function send( value:String ):void
		{
			_socket.writeUTFBytes( value );
			_socket.flush();
		}
		
		
		private function onClose( event:Event ):void
		{
			trace( "SerialPort: onClose" );
			dispatchEvent( event );
		}
		
		private function onConnect( event:Event ):void
		{
			trace( "SerialPort: onConnect connectd:" +_socket.connected);
			
			dispatchEvent( event );
		}
		
		private function onIOErrorEvent( event:IOErrorEvent ):void
		{
			trace( "SerialPort: onIOErrorEvent" );
			dispatchEvent( event );
		}
		
		private function onSecurityError( event:SecurityErrorEvent ):void
		{
			trace( "SerialPort: onSecurityError" );
			dispatchEvent( event );
		}
		
		private function onSocketData( event:ProgressEvent ):void
		{
			dispatchEvent( new DataEvent( DataEvent.DATA, false, false, _socket.readUTFBytes( _socket.bytesAvailable ) ) );
		}
	}
	
	
	
}