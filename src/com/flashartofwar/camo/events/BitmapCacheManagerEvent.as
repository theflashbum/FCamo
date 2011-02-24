package com.flashartofwar.camo.events
{
    import flash.events.Event;

    public class BitmapCacheManagerEvent extends Event
    {
        public static const COMPLETE:String = "com.flashartofwar.camo.events.BitmapCacheManagerEvent.complete";
        public static const CHANGE:String = "com.flashartofwar.camo.events.BitmapCacheManagerEvent.change";
        public static const REMOVED:String = "com.flashartofwar.camo.events.BitmapCacheManagerEvent.removed";
        public static const LOADED:String = "com.flashartofwar.camo.events.BitmapCacheManagerEvent.loaded";

        public var id:String;

        public function BitmapCacheManagerEvent(type:String, id:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.id = id;
        }
    }
}