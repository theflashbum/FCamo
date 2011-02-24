package com.flashartofwar.camo.managers
{
    import com.flashartofwar.camo.events.BitmapCacheManagerEvent;

    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class BitmapCacheManager extends EventDispatcher
    {
        private var cachedBitmaps:Array = [];
        private var loading:Array = [];

        public var overrideBitmaps:Boolean = true;

        public function BitmapCacheManager()
        {
        }

        public function addBitmap(id:String, bitmap:Bitmap, isLoading:Boolean = false):void
        {
            // add bitmap data to cachedBitmap

            if ((cachedBitmaps[id]) && (!overrideBitmaps))
            {
                throw new Error("Bitmap ID " + id + " already exists and can not be overriden. Please set overrideBitmaps flag to true.");
            }
            else if ((cachedBitmaps[id]) && (overrideBitmaps))
            {
                updateBitmap(id, bitmap);
            }
            else
            {
                cachedBitmaps[id] = bitmap;
            }

            if (isLoading && (loading.indexOf(id) == -1))
                flagAsLoading(id);

        }

        public function removeBitmap(id:String):void
        {
            // remove bitmap
            if(hasBitmap(id))
            {
                if(isLoading(id))
                    removeFromLoading(id);

                cachedBitmaps[id] = null;
                fireEvent(BitmapCacheManagerEvent.REMOVED, id);
            }
            // make sure it is not loading
            // fire removed event
        }

        public function hasBitmap(id:String):Boolean
        {
            return cachedBitmaps[id];
        }

        public function getBitmap(id:String):Bitmap
        {
            return hasBitmap(id) ? cachedBitmaps[id] : null;
        }

        public function updateBitmap(id:String, bitmap:Bitmap):void
        {
            // replace bitmap data in cache
            if ((cachedBitmaps[id]) && (!overrideBitmaps))
            {
                throw new Error("Bitmap ID " + id + " already exists and can not be overriden. Please set overrideBitmaps flag to true.");
            }
            else if (!cachedBitmaps[id])
            {
                throw new Error("Bitmap ID " + id + " does not exist.");
            }
            else
            {
                cachedBitmaps[id] = bitmap;
                fireEvent(BitmapCacheManagerEvent.CHANGE, id);
            }
        }

        public function isLoading(id:String):Boolean
        {
            return loading.indexOf(id) == -1 ? false : true;
        }

        public function flagAsLoading(id:String):void
        {
            loading.push(id);
        }

        public function flagAsLoaded(id:String):void
        {
            // Remove id from loading Array
            if(!removeFromLoading(id))
            {
                throw new Error("Bitmap id "+ id + " was not found and could not be flagged as loaded.");                
            }
            else
            {
                fireEvent(BitmapCacheManagerEvent.COMPLETE, id);
            }
        }

        /**
         * Use this when you do not want to fire off an Complete Event.
         * 
         * @param id
         * @return
         */
        public function removeFromLoading(id:String):Boolean
        {
            var index:int = loading.indexOf(id);
            if(index == -1)
            {
                return false;
            }
            else
            {
                loading.splice(index, 1);
                return true;
            }
        }

        private function fireEvent(type:String, id:String):void
        {
            dispatchEvent(new BitmapCacheManagerEvent(type, id ));
        }

    }
}