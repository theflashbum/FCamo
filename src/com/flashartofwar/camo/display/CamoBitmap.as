package com.flashartofwar.camo.display {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.net.URLRequest;

public class CamoBitmap extends Bitmap {

    public function CamoBitmap(bitmapData:BitmapData = null,pixelSnapping:String = "auto",smoothing:Boolean = false)
    {
        super(bitmapData, pixelSnapping, smoothing);
    }

    public function load(url:URLRequest):void
    {
            
    }
}
}