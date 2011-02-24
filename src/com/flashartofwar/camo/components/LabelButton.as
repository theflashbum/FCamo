package com.flashartofwar.camo.components
{
	import com.flashartofwar.camo.behaviors.AbstractBehavior;
	import com.flashartofwar.camo.behaviors.ButtonStyleBehavior;

	public class LabelButton extends Label
    {

		public function LabelButton(styleID:String, styleClass:String = "LabelButton")
        {
            super(styleID, styleClass);
        }

        override protected function init():void
        {
            super.init();
            addButtonBehavior();
        }

        private function addButtonBehavior():void
        {
	        addBehavior(ButtonStyleBehavior);
        }

		override public function get enabled():Boolean
		{
			return _enabled;
		}

		override public function set enabled(value:Boolean):void
		{
			if (_enabled == value)
			{
				return;
			}
			_enabled = value;
			
			for each(var behavior:AbstractBehavior in behaviors)
			{
				behavior.activate = _enabled;
			}
		}
	}
}