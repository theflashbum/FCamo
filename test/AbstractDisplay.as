package com.flashartofwar.camo.display {
    import flash.display.Sprite;
    import flash.events.Event;

    public class AbstractDisplay extends Sprite {
        private const DRAW:String = "draw";

        public function AbstractDisplay(self:AbstractDisplay) {
            if (self == this) {
                super();
            } else {
                throw new Error("AbstractDisplay can not be directly Instantiated");
            }
        }

        /**
         *
         */
        protected function draw():void {
            dispatchEvent(new Event(DRAW));
        }

        /**
         *
         */
        protected function render():void {

        }

        /**
         * Forces a redraw of the component.
         */
        public function drawNow():void {
            render();
        }

    }
}