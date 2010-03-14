/**
 * Label.as
 * Keith Peters
 * version 0.97
 *
 * A Label component for displaying a single line of text.
 *
 * Copyright (c) 2009 Keith Peters
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
    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.enum.CSSProperties;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;

    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Label extends AbstractComponent
    {
        private var _text:String = "";
        private var textField:TextField = new TextField();
        protected var proxyTextFormat:TextFormat = new TextFormat();
        protected var _textAlign:String = CSSProperties.LEFT;

        public function Label(styleID:String, styleSheet:IStyleSheet, applicator:IApplicator, styleClass:String = null, text:String = "")
        {
            _text = text;
            super(this, styleID, styleSheet, applicator, styleClass);
        }

        public function set autoSize(value:String):void
        {
            textField.autoSize = validateAutoSize(value);
            invalidate();
        }

        public function set antiAliasType(value:String):void
        {
            textField.antiAliasType = validateAntiAliasType(value);
            invalidate();
        }

        public function set embedFonts(value:Boolean):void
        {
            textField.embedFonts = value;
            invalidate();
        }

        public function set sharpness(value:Number):void
        {
            textField.sharpness = value;
            invalidate();
        }

        public function get text():String
        {
            return textField.text;
        }

        public function set text(value:String):void
        {
            textField.text = value;
            invalidate();
        }

        public function set textAlign(value:String):void
        {
            _textAlign = value;
            invalidate();
        }

        public function set textFieldWidth(value:Number):void
        {
            textField.width = value;
            invalidate();
        }

        public function set textFieldHeight(value:Number):void
        {
            textField.height = value;
            invalidate();
        }

        public function set textFieldAlign(value:String):void
        {
            proxyTextFormat.align = value;
            invalidate();
        }

        public function set fontFace(value:String):void
        {
            font = value;
            invalidate();
        }

        public function set fontSize(value:Number):void
        {
            size = value;
            invalidate();
        }

        public function set font(value:String):void
        {
            proxyTextFormat.font = value;
            invalidate();
        }

        public function set color(value:uint):void
        {
            proxyTextFormat.color = value;
            invalidate();
        }

        public function set size(value:Number):void
        {
            proxyTextFormat.size = value;
            invalidate();
        }

        public function set letterSpacing(value:Number):void
        {
            proxyTextFormat.letterSpacing = value;
            invalidate();
        }

        /**
         * Initializes the component.
         */
        override protected function init():void
        {
            super.init();
            mouseEnabled = false;
            mouseChildren = false;
        }

        /**
         * Creates and adds the child display objects of this component.
         */
        override protected function addChildren():void
        {
            textField.embedFonts = false;
            textField.selectable = false;
            textField.mouseEnabled = false;
            textField.autoSize = CSSProperties.LEFT;
            textField.text = _text;
            addChild(textField);
            //draw();
        }

        /**
         * Draws the visual ui of the component.
         */
        override protected function draw():void
        {
            proxyTextFormat.align = _textAlign;
            textField.defaultTextFormat = proxyTextFormat;
            textField.setTextFormat(proxyTextFormat);
            super.draw();
        }

        /**
         * Gets / sets the text of this Label.
         */
        public static function validateAntiAliasType(value:String):String
        {
            if (value == CSSProperties.ADVANCED) {
                return value;
            } else {
                return CSSProperties.NORMAL;
            }
        }

        public static function validateAutoSize(value:String):String
        {
            if (value == CSSProperties.LEFT || value == CSSProperties.RIGHT || value == CSSProperties.CENTER) {
                return value;
            } else {
                return CSSProperties.NONE;
            }
        }
    }
}