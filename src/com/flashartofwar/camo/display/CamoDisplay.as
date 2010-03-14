package com.flashartofwar.camo.display {
    import com.flashartofwar.camo.renderers.AdvancedBoxModelRenderer;
    import com.flashartofwar.fboxmodel.FBoxModel;
    import com.flashartofwar.fboxmodel.renderers.BoxModelRenderer;
    import com.flashartofwar.fcss.enum.CSSProperties;
    import com.flashartofwar.fcss.utils.TypeHelperUtil;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    public class CamoDisplay extends FBoxModel {

        protected var maskShape:Shape = new Shape();
        //protected var _className:String;
        protected var _bgImageLoader:Loader;
        protected var cachedBackgroundImages:Dictionary = new Dictionary(true);
        protected var backgroundImageSource:String;
        protected var _cursor:String;
        protected var _verticalAlign:String;
        protected var _align:String;
        protected var zIndex:Number;
        protected var advancedBoxModelRenderer:AdvancedBoxModelRenderer;
        //protected var _id:String;

        /**
         *
         *
         */
        public function CamoDisplay() {

            super();
        }

        override protected function init():void
        {
            //TODO this needs to be thought out better, maskShape should only exist when needed?
            $addChild(maskShape);
            super.init();
        }

        override protected function createRenderer():BoxModelRenderer
        {
            advancedBoxModelRenderer = new AdvancedBoxModelRenderer(_display, graphics, maskShape);
            return advancedBoxModelRenderer;
        }

        /**
         *
         * @param value
         *
         */
        public function set cursor(value:String):void
        {
            _cursor = value;
        }

        /**
         *
         * @return
         *
         */
        public function get cursor():String
        {
            return _cursor;
        }

        /**
         *
         * @param value
         *
         */
        public function set verticalAlign(value:String):void
        {
            _verticalAlign = validateVerticalAlign(value);
        }

        /**
         *
         * @return
         *
         */
        public function get verticalAlign():String
        {
            return _verticalAlign;
        }

        /**
         *
         * @param value
         *
         */
        public function set align(value:String):void
        {
            _align = validateAlign(value);
        }

        /**
         *
         * @return
         *
         */
        public function get align():String
        {
            return _align;
        }

        /**
         *
         * @param value
         *
         */
        public function set overflow(value:String):void
        {
            advancedBoxModelRenderer.overflow = value;
        }

        public function get overflow():String
        {
            return advancedBoxModelRenderer.overflow;
        }


        /**
         *
         * @param value
         *
         */
        public function set backgroundImage(value:String):void
        {
            if (value == "none")
            {
                clearBackgroundImage();
            }
            else
            {
                loadBackgroundImage(TypeHelperUtil.stringToUrlRequest(value));
            }

            invalidate();
        }

        /**
         *
         * @param type
         * @param source
         *
         */
        protected function loadBackgroundImage(request:URLRequest):Loader
        {
            if (!cachedBackgroundImages[request.url])
            {
                _bgImageLoader = new Loader();

                backgroundImageSource = request.url;

                addListeners(_bgImageLoader.contentLoaderInfo);
                _bgImageLoader.load(request);

                return _bgImageLoader;
            }
            else
            {
                sampleBackground(cachedBackgroundImages[request.url]);
            }

            return null;
        }


        /**
         * <p>This is called when a BG Image is loaded. It attaches the BG Image's
         *      BitmapData to the _backgroundImageContainer. If 9 Slice data was
         *      supplied it will put the BitmapData into a ScaleBitmap class, apply
         *      the 9 slice values to allow undistorted stretching of the supplied
         *      BG Image.</p>
         */
        protected function onBGImageLoad(e:Event):void
        {
            var info:LoaderInfo = e.target as LoaderInfo;
            var loader:Loader = info.loader;
            var tempBitmap:Bitmap = Bitmap(loader.content);

            if (backgroundImageSource)
                cachedBackgroundImages[backgroundImageSource] = tempBitmap;

            if (_bgImageLoader)
                if (_bgImageLoader.contentLoaderInfo)
                    removeListeners(_bgImageLoader.contentLoaderInfo);

            sampleBackground(tempBitmap);
        }

        /**
         *
         * @param tempBitmap
         *
         */
        protected function sampleBackground(tempBitmap:Bitmap):void
        {
            boxModelRenderer.backgroundImageBitmap = tempBitmap;
            _bgImageLoader = null;
            invalidate();
        }

        /**
         *
         * @param bitmapData
         * @return
         *
         */
        //              override protected function createBackgroundBitmap(bitmapData:BitmapData):Bitmap
        //              {
        //                      return new Bitmap( bitmapData);
        //              }

        /**
         * <p>attaches listeners to LoaderInfo. This is used to streamline the
         * repetitive adding of listeners in the preload process.</p>
         */
        internal function addListeners(target:LoaderInfo):void
        {
            target.addEventListener(Event.COMPLETE, onBGImageLoad);
            target.addEventListener(IOErrorEvent.IO_ERROR, ioError);
        }

        /**
         * <p>removes listeners to LoaderInfo. This is used to streamline the
         * remove of listeners from the preload process and frees up memory.</p>
         */
        internal function removeListeners(target:LoaderInfo):void
        {
            target.removeEventListener(Event.COMPLETE, onBGImageLoad);
            target.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
            backgroundImageSource = null;
        }


        /**
         * <p>Called when a file can not be loaded. It automatically triggers
         * the next preload.</p>
         */
        internal function ioError(event:IOErrorEvent):void
        {
            //throw new IllegalOperationError("ERROR: Could not load background image.");
        }

        override public function clearBackgroundImage():void
        {
            if (_bgImageLoader)
            {
                try
                {
                    _bgImageLoader.close();
                }
                catch(error:Error)
                {
                    trace("Bg Image Loader could not be closed");
                }
                removeListeners(_bgImageLoader.contentLoaderInfo);
                _bgImageLoader = null;
            }
            super.clearBackgroundImage();
        }


        /**
         * <p>Takes the contents of the Display and draws them into a new display's
         * graphics layer. This is a one time function that is used to reduce the memory
         * footprint of the instance by removing it's display's children. Use this
         * on instances when you know the display is not going to be updated.
         * There is no way to unrasterize.</p>
         *
         */
        public function rasterize():void
        {
            var bmd:BitmapData = new BitmapData(display.width, display.height, true, 0xff0000);
            bmd.draw(display);

            $removeChild(display);
            display.graphics.clear();
            display = null;
            // add new display
            display = new Sprite();
            $addChild(display);

            display.graphics.beginBitmapFill(bmd.clone(), null, false);
            display.graphics.drawRect(0, 0, bmd.width, bmd.height);
            display.graphics.endFill();

            drawNow();
        }

        /**
         *      <p>Checks to see if the child has a zIndex before adding to the display.</p>
         * @param child
         * @return
         *
         */
        override public function addChild(child:DisplayObject):DisplayObject
        {
            invalidate();
            if (child.hasOwnProperty("zIndex"))
            {
                if(!isNaN(child["zIndex"]))
                    return addChildAt(child, validateZIndex(child["zIndex"]));
                else
                    return super.addChild(child);
            }
            
            return super.addChild(child);;
        }

        /**
         *
         * @param value
         * @return
         *
         */
        protected function validateZIndex(value:Number):Number
        {
            return value > numChildren ? numChildren : value;
        }


        /**
         * @private
         * @param value
         * @return
         *
         */
        protected function validateVerticalAlign(value:String):String
        {
            if (value == CSSProperties.TOP || value == CSSProperties.MIDDLE || value == CSSProperties.BOTTOM) {
                return value;
            } else {
                return null;
            }
        }

        /**
         *
         * @param value
         * @return
         *
         */
        protected function validateAlign(value:String):String
        {
            if (value == CSSProperties.LEFT || value == CSSProperties.CENTER || value == CSSProperties.RIGHT) {
                return value;
            } else {
                return null;
            }
        }
    }
}