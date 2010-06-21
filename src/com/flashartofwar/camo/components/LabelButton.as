package com.flashartofwar.camo.components
{
    import com.flashartofwar.camo.behaviors.ButtonStyleBehavior;

    public class LabelButton extends Label
    {
        private var buttonBehavior:ButtonStyleBehavior;

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
            buttonBehavior = new ButtonStyleBehavior(this);
        }
    }
}