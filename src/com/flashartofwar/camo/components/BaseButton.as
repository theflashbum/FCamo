package com.flashartofwar.camo.components {
    import com.flashartofwar.camo.behaviors.ChangeStyleBehavior;
    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;

    public class BaseButton extends AbstractComponent {
        private var buttonBehavior:ChangeStyleBehavior;

        public function BaseButton(styleID:String, styleSheet:IStyleSheet, applicator:IApplicator, styleClass:String = null)
        {
            super(this, styleID, styleSheet, applicator, styleClass);
        }

        override protected function init():void
        {
            super.init();
            addButtonBehavior();
        }

        private function addButtonBehavior():void {
             buttonBehavior = new ChangeStyleBehavior(this);
        }
    }
}