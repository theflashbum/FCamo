package com.flashartofwar.camo.components{
	
    import com.flashartofwar.camo.enum.ComponentState;

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
            if(pseudoSelector == ComponentState.DOWN)
            {
                selected = !selected;
            }

            if(selected && !pseudoSelector)
            {
                pseudoSelector = ComponentState.SELECTED;
            }
            else if (_selected && pseudoSelector)
            {
                pseudoSelector += "_" + ComponentState.SELECTED;
            }

            super.applyDefaultStyle(pseudoSelector);
        }

    }
}

