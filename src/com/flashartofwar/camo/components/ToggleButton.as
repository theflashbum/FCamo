package com.flashartofwar.camo.components{
	import com.flashartofwar.camo.behaviors.ButtonStyleBehavior;

	public class ToggleButton extends LabelButton implements ISelectable
    {
		private var _selected:Boolean;

        public function ToggleButton(styleID:String, styleClass:String = "ToggleButton")
        {
            super(styleID, styleClass);
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(value:Boolean):void
        {
           if(selected == value) return;
			_selected = value;
        }

        override public function applyDefaultStyle(pseudoSelector:String = null):void
        {
            if(pseudoSelector == ButtonStyleBehavior.DOWN)
            {
                selected = !selected;
            }

            if(selected && !pseudoSelector)
            {
                pseudoSelector = ButtonStyleBehavior.SELECTED;
            }
            else if (_selected && pseudoSelector)
            {
                pseudoSelector += "_" + ButtonStyleBehavior.SELECTED;
            }

            styleBehavior.applyDefaultStyle(pseudoSelector);
        }

    }
}

