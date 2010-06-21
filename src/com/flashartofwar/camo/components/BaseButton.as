package com.flashartofwar.camo.components
{
    import com.flashartofwar.camo.behaviors.ButtonStyleBehavior;
    import com.flashartofwar.camo.display.CamoDisplay;

    public class BaseButton extends CamoDisplay
    {
        private var buttonBehavior:ButtonStyleBehavior;

        public function BaseButton(styleID:String, styleClass:String = null)
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