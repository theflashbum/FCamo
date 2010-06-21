package com.flashartofwar.camo.behaviors
{
    import flash.events.MouseEvent;

    public class ButtonStyleBehavior extends AbstractBehavior
    {

        public static const OVER:String = "over";
        public static const DOWN:String = "down";
	    public static const SELECTED:String = "selected";

        protected var inside:Boolean = false;

        public function ButtonStyleBehavior(target:*, activate:Boolean = true)
        {
            super(target, activate);
        }

        override protected function addEventListeners():void
        {
            _target.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            _target.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
            _target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            _target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        }

        override protected function removeEventListeners():void
        {
            _target.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
            _target.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
            _target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            _target.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        }

        protected function onMouseUp(event:MouseEvent):void
        {
            _target.applyDefaultStyle(inside ? OVER : null);
        }

        protected function onMouseDown(event:MouseEvent):void
        {
            _target.applyDefaultStyle(DOWN);
        }

        protected function onRollOver(event:MouseEvent):void
        {
            inside = true;
            _target.applyDefaultStyle(OVER);
        }

        protected function onRollOut(event:MouseEvent):void
        {
            inside = false;
            _target.applyDefaultStyle()
        }
    }
}