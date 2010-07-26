/*
 * The MIT License
 *
 * Original Author:  Jesse Freeman of FlashArtOfWar.com
 * Copyright (c) 2010
 * Class File: Slider.as
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

package com.flashartofwar.camo.components
{
    import com.flashartofwar.camo.behaviors.ISlider;

    import com.flashartofwar.camo.behaviors.SliderBehavior;

    import com.flashartofwar.camo.display.CamoDisplay;

    import flash.display.Sprite;
    import flash.events.Event;

    public class Slider extends CamoDisplay implements ISlider
    {

        protected var sliderBehavior:SliderBehavior;
        protected var _dragger:Sprite;
        protected var _ticks:Number = 0;

        public function Slider(styleID:String, styleClass:String = "Slider")
        {
            super(styleID, styleClass);
        }

        override public function set width(value:Number):void
        {
            super.width = value;
            if (sliderBehavior) sliderBehavior.refresh();
        }

        override public function set height(value:Number):void
        {
            super.height = value;
            if (sliderBehavior) sliderBehavior.refresh();
        }

        public function get value():Number
        {
            return sliderBehavior ? sliderBehavior.value : 0;
        }

        public function set value(value:Number):void
        {
            if(sliderBehavior)
                sliderBehavior.value = value;
        }

        override protected function init():void
        {
            super.init();

            sliderBehavior = new SliderBehavior(this);
            sliderBehavior.addEventListener(Event.CHANGE, onValueChange);
        }


        override protected function addChildren():void
        {
            super.addChildren();
            _dragger = new CamoDisplay(styleID+"Dragger", styleClass+"Dragger");
            addChild(_dragger);
        }

        protected function onValueChange(event:Event):void
        {
            dispatchEvent(event);
        }

        public function get ticks():Number
        {
            return _ticks;
        }

        public function set ticks(value:Number):void
        {
            _ticks = value < 0 ? 0 : value;
        }

        public function get currentTick():Number
        {
            return (value  / _ticks) * _ticks;
        }

        public function get dragger():Sprite
        {
            return _dragger;
        }
    }
}

