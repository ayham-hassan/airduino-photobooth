package com.wheelerstreet.controllers
{
	import com.wheelerstreet.views.RedButton;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class SleepController extends ViewController
	{
		
		protected var _pulseTimer:Timer;
		protected var _button:RedButton;
		protected var _alpha:Number = 1;
		
		public function SleepController(button:RedButton)
		{
			_pulseTimer = new Timer(100);
			_pulseTimer.addEventListener(TimerEvent.TIMER, handlePulseTimer);
			_button = button;
		}
		
		override public function set active(value:Boolean):void
		{
			if(_active == value)
				return; 
				
			if(value) 
				start();
			else 
				stop();
			
			super.active = value;
		}
		
		override protected function start():void
		{
			_pulseTimer.start();
		}
		
		override protected function stop():void
		{
			_pulseTimer.stop();	
		}
		
		protected function handlePulseTimer(e:TimerEvent):void
		{
			var buttonLabelAlpha:Number = _button.label.alpha;
    
			var delta:Number = .05;
			if(_alpha > buttonLabelAlpha && (_alpha - buttonLabelAlpha) >= delta) {
				_button.label.alpha += .05;
			} else {
				_alpha = 0;
			}
			if(_alpha < buttonLabelAlpha && (buttonLabelAlpha - _alpha  ) >= delta) {
				_button.label.alpha -= .05;
			} else {
				_alpha = 1;
			}
			
		}
	
	}
}