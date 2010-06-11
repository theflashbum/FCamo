package com.flashartofwar.camo.renderers
{
    import com.flashartofwar.fboxmodel.renderers.BoxModelRenderer;
    import com.flashartofwar.fcss.enum.CSSProperties;

    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;

    public class AdvancedBoxModelRenderer extends BoxModelRenderer
    {

        protected var _overflow:String;
        private var maskShape:Shape;

        public function AdvancedBoxModelRenderer(display:Sprite, graphics:Graphics, maskShape:Shape)
        {

            this.maskShape = maskShape;
            super(display, graphics);
        }

        public function set overflow(value:String):void
        {
            _overflow = value;
            // Parse Overflow
            switch (value)
            {
                case CSSProperties.HIDDEN:
                {
                    activateOverflowHidden();
                    break;
                }
                default:
                {
                    clearOverflow();
                    break;
                }
            }
        }

        public function get overflow():String
        {
            return _overflow;
        }

        /**
         *
         *
         */
        protected function activateOverflowHidden():void
        {
            // Draw mask around display
            maskShape.graphics.clear();
            trace("mask", _width, _height);
            // Make sure we don't draw a mask with no width or height or it will not work
            if (_width == 0) _width = 1;
            if (_height == 0) _height = 1;

            maskShape.graphics.beginFill(0xff0000, 1);
            maskShape.graphics.drawRect(0, 0, _width, _height);
            maskShape.graphics.endFill();

            display.mask = maskShape;
        }

        /**
         *
         *
         */
        protected function clearOverflow():void
        {
            maskShape.graphics.clear();

            display.mask = null;
        }

        /**
         *
         * @param value
         *
         */
        override public function set width(value:Number):void
        {
            if (_overflow == CSSProperties.HIDDEN) maskShape.width = _width;
            super.width = value;
        }

        /**
         *
         * @return
         *
         */
        override public function get width():Number
        {
            return (_overflow == CSSProperties.HIDDEN) ? (borderLeft + paddingLeft + maskShape.width + paddingRight + borderRight) : super.width;
        }

        /**
         *
         * @param value
         *
         */
        override public function set height(value:Number):void
        {
            super.height = value;
            if (_overflow == CSSProperties.HIDDEN) maskShape.height = _height;
        }

        override public function get height():Number
        {
            return (_overflow == CSSProperties.HIDDEN) ? (borderTop + paddingTop + maskShape.height + paddingBottom + borderBottom) : super.height;
        }

        /**
         *
         * @return
         *
         */
        override public function get displayWidth():Number
        {
            if (_overflow == CSSProperties.HIDDEN)
            {
                return maskShape.width;
            }
            else
            {
                return super.displayWidth;
            }

        }

        /**
         *
         * @return
         *
         */
        override public function get displayHeight():Number
        {

            if (_overflow == CSSProperties.HIDDEN)
            {
                return maskShape.height;
            }
            else
            {
                return super.displayHeight;
            }

        }

        /**
         *
         *
         */
        override public function drawBoxModel():void
        {

            if (_overflow == CSSProperties.HIDDEN)
            {
                maskShape.width = _width;
                maskShape.height = _height;
                maskShape.x = paddingLeft + borderLeft;
                maskShape.y = paddingTop + borderTop;
            }

            super.drawBoxModel();
        }

    }
}