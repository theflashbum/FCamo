package com.flashartofwar.camo.behaviors
{
    import flash.events.MouseEvent;

    public class ChangeStyleBehavior
    {

        private var _target:*;
        private var _activate:Boolean;
        private const OVER:String = "over";

        public function ChangeStyleBehavior(target:*, activate:Boolean = true)
        {
            this.target = target;
            this.activate = activate;
            init();
        }

        private function init():void
        {

        }

        public function set activate(activate:Boolean):void
        {
            _activate = activate;
            if (_activate)
            {
                addEventListeners();
            }
            else
            {
                removeEventListeners();
            }
        }

        private function addEventListeners():void
        {
            _target.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            _target.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
        }

        private function onRollOver(event:MouseEvent):void
        {
            _target.applyDefaultStyle(OVER);
        }

        private function onRollOut(event:MouseEvent):void
        {
            _target.applyDefaultStyle()
        }


        private function removeEventListeners():void
        {
            _target.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
            _target.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
        }

        public function get activate():Boolean
        {
            return _activate;
        }

        public function set target(value:*):void
        {
            _target = value;

        }
    }
}