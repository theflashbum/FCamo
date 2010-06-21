package com.flashartofwar.camo.components{

    public class ToggleButton extends BaseButton
    {
        private const SELECTED:String = "selected";
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
            _selected = value;
        }

        override public function applyDefaultStyle(pseudoSelector:String = null):void
        {
            if(pseudoSelector == "down")
                _selected = !_selected;

            if(_selected && !pseudoSelector)
            {
                pseudoSelector = SELECTED;
            }
            else if (_selected && pseudoSelector)
            {
                pseudoSelector += "_" + SELECTED;
            }

            styleBehavior.applyDefaultStyle(pseudoSelector);
        }

    }
}

