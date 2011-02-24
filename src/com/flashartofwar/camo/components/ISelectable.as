package com.flashartofwar.camo.components
{
	public interface ISelectable
	{
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void;
	}
}