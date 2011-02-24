/**
 * Modified Version of
 * Slider.as
 * Keith Peters
 * version 0.9.5
 *
 * Abstract base slider class for HSlider and VSlider.
 *
 * Copyright (c) 2010 Keith Peters
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.flashartofwar.camo.behaviors
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    public class SliderBehavior extends EventDispatcher implements ISlider
    {
        public static const HORIZONTAL:String = "horizontal";
        public static const VERTICAL:String = "vertical";
        public static const DRAGGER:String = "dragger";
        public static const TRACK:String = "track";

        protected var target:Sprite;
        protected var _backClick:Boolean = true;
        protected var _value:Number = 0;
        protected var _max:Number = 100;
        protected var _min:Number = 0;
        protected var _orientation:String;
        //protected var _tick:Number = 1;
        //protected var _numTics:Number = 48; //total width of images / 480, rounded up.

        public function SliderBehavior(target:Sprite)
        {

            _orientation = HORIZONTAL;

            if (target is ISlider && target is Sprite)
            {
                this.target = target;
            }
            else
            {
                throw new Error("Target must implement ISlider and be a Sprite")
            }
            init();
        }

        public function set draggerX(value:Number):void
        {
            target["draggerX"] = value;
        }

        public function get draggerX():Number
        {
            return target["draggerX"];
        }

        /**
         * Initializes the component.
         */
        protected function init():void
        {

            dragger.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);

            if (_backClick)
            {
                target.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
            }
            else
            {
                target.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
            }
        }

        /**
         * Find position of nearest tick
         */
         protected function nearestTick(tl:Number, nt:Number, rp:Number):Number
         {
            return (tl/nt)*Math.round(nt*rp/tl);
         }

        /**
         * Adjusts value to be within minimum and maximum.
         */
        protected function correctValue():void
        {
            if (_max > _min)
            {
                _value = Math.min(_value, _max);
                _value = Math.max(_value, _min);
            }
            else
            {
                _value = Math.max(_value, _max);
                _value = Math.min(_value, _min);
            }
        }

        /**
         * Adjusts position of handle when value, maximum or minimum have changed.
         */
        public function refresh():void
        {
            var range:Number;
            if (_orientation == HORIZONTAL)
            {
                range = target.width - dragger.width;
                draggerX = (_value - _min) / (_max - _min) * range;
            }
            else
            {
                range = target.height - dragger.height;
                dragger.y = target.height - target.width - (_value - _min) / (_max - _min) * range;
            }
        }

        ///////////////////////////////////
        // event handlers
        ///////////////////////////////////

        /**
         * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
         * @param event The MouseEvent passed by the system.
         */
        protected function onBackClick(event:MouseEvent):void
        {
            if (_orientation == HORIZONTAL)
            {
                draggerX = target.mouseX - dragger.width / 2;
                draggerX = Math.max(draggerX, 0);
                draggerX = Math.min(draggerX, target.width - dragger.width);
                if(ticks > 0)
                {
                    //this next line has a hilarious effect.
                    draggerX = nearestTick(target.width - dragger.width, ticks, draggerX);
                }
                _value = draggerX / (target.width - dragger.width) * (_max - _min) + _min;
            }
            else
            {
                dragger.y = target.mouseY - dragger.height / 2;
                dragger.y = Math.max(dragger.y, 0);
                dragger.y = Math.min(dragger.y, target.height - dragger.height);
                _value = (target.height - dragger.height - dragger.y) / (target.height - dragger.height) * (_max - _min) + _min;
            }
            dispatchEvent(new Event(Event.CHANGE));

        }

        /**
         * Internal mouseDown handler. Starts dragging the handle.
         * @param event The MouseEvent passed by the system.
         */
        protected function onDrag(event:MouseEvent):void
        {
            target.stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
            target.stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
            if (_orientation == HORIZONTAL)
            {
                dragger.startDrag(false, new Rectangle(0, 0, target.width - dragger.width, 0));
            }
            else
            {
                dragger.startDrag(false, new Rectangle(0, 0, 0, target.height - dragger.height));
            }
        }

        /**
         * Internal mouseUp handler. Stops dragging the handle.
         * @param event The MouseEvent passed by the system.
         */
        protected function onDrop(event:MouseEvent):void
        {
            target.stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
            target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);

            if(ticks > 0)
            {
                var oldValue:Number = _value;
                if (_orientation == HORIZONTAL)
                {
                    //this next line has a hilarious effect.
                    draggerX = nearestTick(target.width - dragger.width, ticks, draggerX);
                    _value = draggerX / (target.width - dragger.width) * (_max - _min) + _min;
                }
                else
                {
                   // _value = (target.height - dragger.height - dragger.y) / (target.height - dragger.height) * (_max - _min) + _min;
                }
                if (_value != oldValue)
                {
                    dispatchEvent(new Event(Event.CHANGE));
                }
            }

            target.stopDrag();
        }

        /**
         * Internal mouseMove handler for when the handle is being moved.
         * @param event The MouseEvent passed by the system.
         */
        protected function onSlide(event:MouseEvent):void
        {
            var oldValue:Number = _value;
            if (_orientation == HORIZONTAL)
            {
                _value = draggerX / (target.width - dragger.width) * (_max - _min) + _min;
            }
            else
            {
                _value = (target.height - dragger.height - dragger.y) / (target.height - dragger.height) * (_max - _min) + _min;
            }
            if (_value != oldValue)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }


        ///////////////////////////////////
        // getter/setters
        ///////////////////////////////////

        /**
         * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
         */
        public function set backClick(b:Boolean):void
        {
            _backClick = b;
        }

        public function get backClick():Boolean
        {
            return _backClick;
        }

        /**
         * Sets / gets the current value of this slider.
         */
        public function set value(v:Number):void
        {
            _value = v;
            
            correctValue();
            refresh();

        }

        public function get value():Number
        {
            return _value;//( / _tick) * _tick;
        }

        /**
         * Gets / sets the maximum value of this slider.
         */
        public function set maximum(m:Number):void
        {
            _max = m;
            correctValue();
            refresh();
        }

        public function get maximum():Number
        {
            return _max;
        }

        /**
         * Gets / sets the minimum value of this slider.
         */
        public function set minimum(m:Number):void
        {
            _min = m;
            correctValue();
            refresh();
        }

        public function get minimum():Number
        {
            return _min;
        }

        /**
         * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number.
         */
        /*public function set tick(t:Number):void
        {
            _tick = t;
        }

        public function get tick():Number
        {
            return _tick;
        }*/

        public function get ticks():Number
        {
            return ISlider(target).ticks;
        }

        public function get dragger():Sprite
        {
            return ISlider(target).dragger;
        }
    }
}