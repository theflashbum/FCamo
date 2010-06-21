package com.flashartofwar.camo.events
{
    import flash.events.Event;

    public class StyleChangedEvent extends Event
    {
        public function StyleChangedEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}