package com.flashartofwar.camo.behaviors
{
    import flash.events.EventDispatcher;

    public class AbstractBehavior extends EventDispatcher
    {

        protected var _target:*;
        protected var _activate:Boolean;
                
        public function AbstractBehavior(target:*, activate:Boolean = true)
        {
            this.target = target;
            this.activate = activate;
        }

        public function set target(instance:*):void
        {
            _target = instance;
        }

        public function get activate():Boolean
        {
            return _activate;
        }
        
        public function set activate(value:Boolean):void
        {
            if(activate == value) return;
	        _activate = value;
            if (_activate)
            {
                addEventListeners();
            }
            else
            {
                removeEventListeners();
            }
        }
        
        protected function addEventListeners():void
        {

        }

        protected function removeEventListeners():void
        {

        }

    }
}