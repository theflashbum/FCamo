package com.flashartofwar.camo.behaviors {
    import flash.events.EventDispatcher;

    public class AbstractBehavior extends EventDispatcher {

        protected var _target:*;

        public function AbstractBehavior(target:*) {
            this.target = target;
        }

        public function set target(instance:*):void {
            _target = instance;
        }
    }
}