package com.flashartofwar.camo.display
{
    import com.flashartofwar.camo.events.BitmapCacheManagerEvent;
    import com.flashartofwar.camo.managers.BitmapCacheManager;
    import com.flashartofwar.camo.managers.SingletonManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;

    public class CamoBitmap extends Bitmap
    {

        public static var cachedBitmaps:BitmapCacheManager = SingletonManager.getClassReference(BitmapCacheManager);
        private var loader:Loader;
        protected var id:String;
        
        public function CamoBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }

        /**
         * <p>This setter fires a "change" event to notify anything listening
         * to this instance that the BitmapData has been changed.</p>
         *
         * @param value
         *
         */
        override public function set bitmapData(value:BitmapData):void
        {
            super.bitmapData = value;
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function load(url:String):void
        {
            if(url == id)
            {
                return;
            }
            else
            {
                id = url;
                if (cachedBitmaps.hasBitmap(url) && !cachedBitmaps.isLoading(url))
                {
                    // Bitmap is cached and is already loaded

                    bitmapData = cachedBitmaps.getBitmap(url).bitmapData.clone();
                }
                else if (cachedBitmaps.hasBitmap(url) && cachedBitmaps.isLoading(url))
                {
                    // Bitmap is cached but not loaded.
                    addChangeListener(cachedBitmaps);
                    addRemoveFromCacheListener(cachedBitmaps);
                    // Add event listener to BitmapCache for an update matching the url id.
                    // also need to listen to a remove event in case it is waiting for a load.
                    // then call displayBitmap
                }
                else
                {
                    // No cache and not loading so make a load request.
                    cachedBitmaps.addBitmap(url, new Bitmap());
                    cachedBitmaps.flagAsLoading(url);
                    loader = new Loader();

                                        
                    addLoadListeners(loader.contentLoaderInfo);
                    loader.load(new URLRequest(url));
                }
            }
        }

        private function addRemoveFromCacheListener(cachedBitmaps:BitmapCacheManager):void
        {
            if(!cachedBitmaps.hasEventListener(Event.REMOVED))
            {
                cachedBitmaps.addEventListener(Event.REMOVED, onRemovedFromCache);
            }
        }

        private function onRemovedFromCache(event:Event):void
        {
            //TODO need to add logic when a bitmap we want has been removed
        }

        private function addChangeListener(target:BitmapCacheManager):void
        {
            target.addEventListener(BitmapCacheManagerEvent.CHANGE, onChange);
        }

        private function removeChangeListener(target:BitmapCacheManager):void
        {
            target.removeEventListener(BitmapCacheManagerEvent.CHANGE, onChange);
        }

        private function onChange(event:BitmapCacheManagerEvent):void
        {
            if(event.id == id)
            {
                removeChangeListener(cachedBitmaps);
                bitmapData = cachedBitmaps.getBitmap(id).bitmapData.clone();
                dispatchEvent(new Event(Event.CHANGE, true, true))
            }

        }

        /**
         * <p>attaches listeners to LoaderInfo. This is used to streamline the
         * repetitive adding of listeners in the preload process.</p>
         */
        protected function addLoadListeners(target:LoaderInfo):void
        {
            target.addEventListener(Event.COMPLETE, onLoad);
            target.addEventListener(IOErrorEvent.IO_ERROR, ioError);
        }

        /**
         * <p>removes listeners to LoaderInfo. This is used to streamline the
         * remove of listeners from the preload process and frees up memory.</p>
         */
        protected function removeLoadListeners(target:LoaderInfo):void
        {
            target.removeEventListener(Event.COMPLETE, onLoad);
            target.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
        }


        /**
         * <p>Called when a file can not be loaded. It automatically triggers
         * the next preload.</p>
         */
        protected function ioError(event:IOErrorEvent):void
        {
            //throw new IllegalOperationError("ERROR: Could not load background image.");
        }

        /**
         * <p>This is called when a BG Image is loaded. It attaches the BG Image's
         * BitmapData to the _backgroundImageContainer. If 9 Slice data was
         * supplied it will put the BitmapData into a ScaleBitmap class, apply
         * the 9 slice values to allow undistorted stretching of the supplied
         * BG Image.</p>
         */
        protected function onLoad(e:Event):void
        {
            var info:LoaderInfo = e.target as LoaderInfo;
            var loader:Loader = info.loader;
            removeLoadListeners(loader.contentLoaderInfo);

            addChangeListener(cachedBitmaps);
            
            cachedBitmaps.flagAsLoaded(id);
            cachedBitmaps.updateBitmap(id, Bitmap(loader.content));

            loader = null;
        }

        public function destroy():void
        {
            if(cachedBitmaps.hasEventListener(Event.REMOVED))
            {
                cachedBitmaps.removeEventListener(Event.REMOVED, onRemovedFromCache);
            }
        }
    }
}