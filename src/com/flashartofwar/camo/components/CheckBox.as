package com.flashartofwar.camo.components{

    public class CheckBox extends BaseButton
    {
        private const SELECTED:String = "selected";
        private var _selected:Boolean;

        public function CheckBox(styleID:String, styleClass:String = "CheckBox")
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
                pseudoSelector = styleSuffix;
            }
            else if (_selected && pseudoSelector)
            {
                pseudoSelector += "_" + styleSuffix;
            }

            styleBehavior.applyDefaultStyle(pseudoSelector);
        }
        
        protected function get styleSuffix():String
        {
            return _selected ? SELECTED : null;
        }
        
    }
}

