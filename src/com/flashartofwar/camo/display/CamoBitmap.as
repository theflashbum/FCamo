package com.flashartofwar.camo.display {
    import com.flashartofwar.camo.managers.BitmapCacheManagerTest;

    import com.flashartofwar.camo.managers.SingletonManager;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.IEventDispatcher;
    import flash.net.URLRequest;

public class CamoBitmap extends Bitmap {

    public static var cachedBitmaps:BitmapCacheManagerTest = SingletonManager.getClassReference(BitmapCacheManagerTest);
    private var loader:Loader = new Loader();
    
    public function CamoBitmap(bitmapData:BitmapData = null,pixelSnapping:String = "auto",smoothing:Boolean = false)
    {
        super(bitmapData, pixelSnapping, smoothing);
    }

    public function load(url:String):void
    {
       /* if(cachedBitmaps.hasBitmap(url) && !cachedBitmaps.isLoading(url))
        {
            // Bitmap is cached and is already loaded
            displayBitmap(cachedBitmaps.getBitmap(url))
        }
        else if(cachedBitmaps.hasBitmap(url) && cachedBitmaps.isLoading(url))
        {
            // Bitmap is cached but not loaded.

            // Add event listener to BitmapCache for an update matching the url id.
            // also need to listen to a remove event in case it is waiting for a load.
            // then call displayBitmap
        }
        else
        {
            // No cache and not loading so make a load request.
            cachedBitmaps.addBitmap(url, new Bitmap());
            cachedBitmaps.flagAsLoading(url);
            addEventListeners(loader.contentLoaderInfo);
            loader.load(new URLRequest(url));
        }*/
    }

    private function addEventListeners(contentLoaderInfo:IEventDispatcher):void
    {
    }

    private function removeEventListeners(contentLoaderInfo:IEventDispatcher):void
    {
    }

    protected function displayBitmap(bitmap:Bitmap):void
    {
        
    }


}
}