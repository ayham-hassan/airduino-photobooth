package com.wheelerstreet.controllers
{
	import com.wheelerstreet.config.Config;
	import com.wheelerstreet.events.ArduinoButtonEvent;
	import com.wheelerstreet.views.HelpPanel;
	import com.wheelerstreet.views.PhotoStrip;
	import com.wheelerstreet.views.RedButton;
	
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import mx.containers.Canvas;
	import mx.core.WindowedApplication;
	import mx.managers.PopUpManager;
	
	public class MainController
	{
		// view controllers 
		protected var _sessionController:SessionController;
		protected var _sleepController:SleepController;
		// controllers
		protected var _arduinoController:ArduinoController;
		// views
		protected var _mainApp:WindowedApplication;
		protected var _button:RedButton;
		protected var _photoStrip:PhotoStrip;
		protected var _frame:Canvas;
		protected var _helpPanel:HelpPanel;
		// serial connection
		
		public function MainController(mainApp:WindowedApplication, button:RedButton, photoStrip:PhotoStrip, frame:Canvas)
		{
			_mainApp = mainApp; // LayoutContainer
			_button = button;
			_photoStrip = photoStrip;
			_frame = frame;
			
			_arduinoController = new ArduinoController();
			// view controllers
			
			_sessionController = new SessionController(photoStrip,frame);
			_sleepController = new SleepController(button);
			_sleepController.active = true;
			
			addEventListeners();
		}
		
		protected function addEventListeners():void
		{
			
			_mainApp.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			_mainApp.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			
			_arduinoController.addEventListener(ArduinoButtonEvent.BUTTON_UP, handleMouseUp);
			_arduinoController.addEventListener(ArduinoButtonEvent.BUTTON_DOWN, handleMouseDown);
		}

		public function handleMouseUp(e:Event):void
		{
			_button.state = RedButton.UP;	
			startSession();
		}
		
		public function handleMouseDown(e:Event):void
		{		
			_button.state = RedButton.DOWN;
		}
		
		protected function startSession():void
		{
			if(_sleepController.active)
				_sleepController.active = false;
			if(!_sessionController.active)
				_sessionController.active = true;
			else {
				trace("session already started..");
				//
				_sessionController.additionalClick();
			}	
					
		}
		
		protected function endSession():void
		{		
			if(!_sleepController.active)
				_sleepController.active = true;
		}

		/**
		 * Keyboard event handler
		 */
		 
		protected function handleKeyDown(e:KeyboardEvent):void
		{
			switch(e.charCode.toString()) {
				// space 
				case("32"): {
					_button.state = RedButton.DOWN;
					break;
				}
			}
		} 
		 
		protected function handleKeyUp(e:KeyboardEvent):void
		{
			switch(e.charCode.toString()) {
				// space 
				case("32"): {
					_button.state = RedButton.UP;
					startSession();
					break;
				}
				// ? 
				case("47"): {
					toggleHelp();
					break;
				}
				// f
				case("102"): {
					fullscreen();
					break;
				}				
				// s
				case("115"): {
					if(Config.instance.useSerialConnection)
						trace("restart serial connection");
					break;
				}
				default:
					trace(e.charCode);
			}
		}
		
		
		
		public function toggleHelp():void
		{
			if(_helpPanel) {
				PopUpManager.removePopUp(_helpPanel);
				_helpPanel = null;
			} else {
				_helpPanel = PopUpManager.createPopUp(_mainApp,HelpPanel,true) as HelpPanel;
				PopUpManager.centerPopUp(_helpPanel);
			}
			
		}
		
		
		public function fullscreen():void
		{
			if(!_mainApp)
				return;
			var stage:Stage = _mainApp.stage;
			
			if(stage.displayState == StageDisplayState.NORMAL)
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			else 
				stage.displayState = StageDisplayState.NORMAL;
		}
		
	}
}