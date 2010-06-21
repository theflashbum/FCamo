package com.flashartofwar.camo.display
{
    import com.flashartofwar.camo.display.CamoBitmap;
    import com.flashartofwar.camo.display.CamoBitmap;
    import com.flashartofwar.camo.enum.ComponentState;
    import com.flashartofwar.camo.events.StyleChangedEvent;
    import com.flashartofwar.camo.managers.SingletonManager;
    import com.flashartofwar.camo.renderers.AdvancedBoxModelRenderer;
    import com.flashartofwar.fboxmodel.FBoxModel;
    import com.flashartofwar.fboxmodel.renderers.BoxModelRenderer;
    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.applicators.StyleApplicator;
    import com.flashartofwar.fcss.behaviors.ApplyStyleBehavior;
    import com.flashartofwar.fcss.styles.IStyle;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;
    import com.flashartofwar.fcss.stylesheets.StyleSheetCollection;
    import com.flashartofwar.fcss.typer.splitTypeFromSource;
    import com.flashartofwar.fcss.validators.validateAlign;
    import com.flashartofwar.fcss.validators.validateVerticalAlign;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;

    public class CamoDisplay extends FBoxModel
    {

        protected var maskShape:Shape = new Shape();
        protected var _cursor:String;
        protected var _verticalAlign:String;
        protected var _align:String;
        protected var zIndex:Number;
        protected var advancedBoxModelRenderer:AdvancedBoxModelRenderer;
        protected var styleBehavior:ApplyStyleBehavior;
        protected var styleID:String = "";
        protected var styleSheetCollection:IStyleSheet = SingletonManager.getClassReference(StyleSheetCollection);
        protected var applicator:IApplicator = SingletonManager.getClassReference(StyleApplicator);
        protected var styleClass:String;

        /**
         *
         *
         */
        public function CamoDisplay(styleID:String, styleClass:String = "CamoDisplay")
        {

            this.styleID = styleID;
            this.styleClass = styleClass;

            super();
        }

        override protected function init():void
        {
            //TODO this needs to be thought out better, maskShape should only exist when needed?
            $addChild(maskShape);
            super.init();
            addChildren();
            addStyleBehavior();
        }

        protected function addStyleBehavior():void
        {
            styleBehavior = new ApplyStyleBehavior(this, applicator, styleSheetCollection, styleID, styleClass);
        }

        /**
         * Overriden in subclasses to create child display objects.
         */
        protected function addChildren():void
        {

        }

        /**
         * Moves the component to the specified position.
         * @param xpos the x position to move the component
         * @param ypos the y position to move the component
         */
        public function move(xpos:Number, ypos:Number):void
        {
            x = Math.round(xpos);
            y = Math.round(ypos);
        }

        /**
         * Sets the size of the component.
         * @param w The width of the component.
         * @param h The height of the component.
         */
        public function setSize(w:Number, h:Number):void
        {
            width = w;
            height = h;
        }

        /**
         * Overrides the setter for x to always place the component on a whole pixel.
         */
        override public function set x(value:Number):void
        {
            super.x = Math.round(value);
        }

        /**
         * Overrides the setter for y to always place the component on a whole pixel.
         */
        override public function set y(value:Number):void
        {
            super.y = Math.round(value);
        }

        // Implemented from IApplyStyleBehavior

        public function applyDefaultStyle(pseudoSelector:String = null):void
        {
            styleBehavior.applyDefaultStyle(pseudoSelector);

            var eventType:String = pseudoSelector ? pseudoSelector : ComponentState.DEFAULT;
            
            dispatchEvent(new StyleChangedEvent(eventType, true, true));
        }

        public function applyStyle(style:IStyle):void
        {
            styleBehavior.applyStyle(style);
        }

        public function get className():String
        {
            return styleBehavior.className;
        }

        public function get id():String
        {
            return styleBehavior.id;
        }

        public function get defaultStyleNames():Array
        {
            return styleBehavior.defaultStyleNames;
        }

        public function getPseudoSelector(state:String):IStyle
        {
            return styleBehavior.getPseudoSelector(state);
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
                invalidate();
            }
            else
             {
             var request:Object = splitTypeFromSource(value);
             var type:String = request.type;
             var source:String = request.source;

             createBackgroundBitmap(request.source);

             }


        }

        protected function createBackgroundBitmap(source:String):void
        {

            if(!(backgroundImageBitmap is CamoBitmap))
            {
               var cb:CamoBitmap = new CamoBitmap();
               cb.addEventListener(Event.CHANGE, onBackgroundImageBitmapChange);
               cb.load(source);
            }
            else
            {
                CamoBitmap(backgroundImageBitmap).load(source);
            }

        }

        protected function onBackgroundImageBitmapChange(event:Event):void
        {
            sampleBackground(event.target as Bitmap);
        }

        /**
         *
         * @param tempBitmap
         *
         */
        protected function sampleBackground(tempBitmap:Bitmap):void
        {
            boxModelRenderer.backgroundImageBitmap = tempBitmap;
            invalidate();
        }

        override public function clearBackgroundImage():void
        {
            if(backgroundImageBitmap is CamoBitmap)
                CamoBitmap(backgroundImageBitmap).destroy();

            //TODO Remove any listeners we may have
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
         * <p>Checks to see if the child has a zIndex before adding to the display.</p>
         * @param child

         *
         */
        override public function addChild(child:DisplayObject):DisplayObject
        {
            invalidate();
            if (child.hasOwnProperty("zIndex"))
            {
                if (!isNaN(child["zIndex"]))
                    return addChildAt(child, validateZIndex(child["zIndex"]));
                else
                    return super.addChild(child);
            }

            return super.addChild(child);

        }

        /**
         *
         * @param value

         *
         */
        protected function validateZIndex(value:Number):Number
        {
            return value > numChildren ? numChildren : value;
        }




        public function destroy():void
        {
            //TODO need to add logic for destroy
        }
	    protected var _enabled:Boolean = true;
	    public function get enabled():Boolean
	    {
		    return _enabled;
	    }

	    public function set enabled(value:Boolean):void
	    {
		    _enabled = value;
	    }
    }
}