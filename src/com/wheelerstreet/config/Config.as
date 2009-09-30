package com.wheelerstreet.config
{

	[Bindable]
	public class Config 
	{
		
		public var useSerialConnection:Boolean;
		
		private static const _instance:Config = new Config(SingletonLock);
		
		public static function get instance():Config
		{
			return _instance;
		}
		
		public function Config(lock:Class) 
		{
			if(lock != SingletonLock)
				throw new Error("Invalide Singleton Access");
				
			// TODO at some point this should be loaded externally or put into a simple name value database
			
			useSerialConnection = false;
			
		}
		
		
	}
	
	
	
	
}

class SingletonLock {}