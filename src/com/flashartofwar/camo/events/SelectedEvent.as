package com.flashartofwar.camo.events
{
	import flash.events.Event;

	public class SelectedEvent extends Event
	{
		public static const SELECTED:String = "toggled";
		public var selected:Boolean;

		public function SelectedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new SelectedEvent(type, bubbles, cancelable);
		}
	}
}