package com.flashartofwar.camo.managers
{
    import flash.display.Bitmap;
    import flash.events.Event;

    public class BitmapCacheManager
    {
        private var cachedBitmaps:Array = [];
        private var loading:Array = [];

        public var overrideBitmaps:Boolean;
        
        public function BitmapCacheManager()
        {
        }

        public function addBitmap(id:String, bitmap:Bitmap, isLoading:Boolean = false):void
        {
            // add bitmap data to cachedBitmap

            if((cachedBitmaps[id]) && (!overrideBitmaps))
            {
                throw new Error("Bitmap ID "+id+" already exists and can not be overriden. Please set overrideBitmaps flag to true.");
            }
            else
            {
                cachedBitmaps[id] = bitmap;
                if(isLoading && (loading.indexOf(id) == -1))
                    addToLoading(id, bitmap);
            }

        }

        private function addToLoading(id:String, target:Bitmap):void
        {
            loading.push(id);
            target.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
        }

        private function onComplete(event:Event):void
        {
            //removeFromLoadingList
        }

        public function removeBitmap(id:String):void
        {
            // remove bitmap
            // make sure it is not loading
            // fire removed event
        }

        public function hasBitmap(id:String):Boolean
        {
            return id in cachedBitmaps;
        }

        public function getBitmap(id:String):Bitmap
        {
            return hasBitmap(id) ? cachedBitmaps[id] : null;
        }

        public function updateBitmap(id:String):void
        {
            // replace bitmap data in cache    
        }

        public function isLoading(id:String):void
        {
            // check to see if id exists in loading Array.    
        }

        public function flagAsLoading(id:String):void
        {
            // Add id to loading Array
        }

        public function flagAsLoaded(id:String):void
        {
            // Remove id from loading Array   
        }

    }
}