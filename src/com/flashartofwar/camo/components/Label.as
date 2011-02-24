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
    import com.flashartofwar.camo.display.CamoDisplay;
    import com.flashartofwar.fcss.enum.CSSProperties;

    import flash.events.Event;
    import flash.text.StyleSheet;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextLineMetrics;

    public class Label extends CamoDisplay
    {

        protected var _styleSheet:StyleSheet;
        protected var textField:TextField = new TextField();
        protected var _textTransform:String = CSSProperties.NONE;
        protected var _textAlign:String = CSSProperties.LEFT;

        protected var proxyTextFormat:TextFormat = new TextFormat();

        public function get instance():TextField
        {
            return textField;
        }

        public function get textTransform():String
        {
            return _textTransform;
        }

        public function set leading(value:Number):void
        {
            proxyTextFormat.leading = value;
            invalidate();
        }

        public function set textTransform(value:String):void
        {
            _textTransform = validateTextTransform(value);
        }

        /**
         *
         * @param value
         *
         */
        public function set textAlign(value:String):void
        {
            _textAlign = value;
        }

        /**
         *
         * @return
         *
         */
        public function get textFieldWidth():Number
        {
            return textField.width;
        }

        /**
         *
         * @param value
         *
         */
        public function set textFieldWidth(value:Number):void
        {
            textField.width = value;
        }

        /**
         *
         * @return
         *
         */
        public function get textFieldHeight():Number
        {
            return textField.height;
        }

        /**
         *
         * @param value
         *
         */
        public function set textFieldHeight(value:Number):void
        {
            textField.height = value;
        }

        /**
         *
         * @return
         *
         */
        public function get autoSize():String
        {
            return textField.autoSize;
        }

        /**
         *
         * @param value
         *
         */
        public function set autoSize(value:String):void
        {
            textField.autoSize = validateAutoSize(value);
        }

        /**
         *
         * @return
         *
         */
        public function get antiAliasType():String
        {
            return textField.antiAliasType;
        }

        /**
         *
         * @param value
         *
         */
        public function set antiAliasType(value:String):void
        {
            textField.antiAliasType = validateAntiAliasType(value);
        }

        /**
         *
         * @return
         *
         */
        public function get condenseWhite():Boolean
        {
            return textField.condenseWhite;
        }

        /**
         *
         * @param value
         *
         */
        public function set condenseWhite(value:Boolean):void
        {
            textField.condenseWhite = value;
        }

        /**
         *
         * @return
         *
         */
        public function get defaultTextFormat():TextFormat
        {
            return textField.defaultTextFormat;
        }

        /**
         *
         * @param value
         *
         */
        public function set defaultTextFormat(value:TextFormat):void
        {
            textField.defaultTextFormat = value;
        }

        /**
         *
         * @return
         *
         */
        public function get embedFonts():Boolean
        {
            return textField.embedFonts;
        }

        /**
         *
         * @param value
         *
         */
        public function set embedFonts(value:Boolean):void
        {
            textField.embedFonts = value;
        }

        /**
         *
         * @return
         *
         */
        public function get gridFitType():String
        {
            return textField.gridFitType;
        }

        /**
         *
         * @param value
         *
         */
        public function set gridFitType(value:String):void
        {
            textField.gridFitType = value;
        }

        /**
         *
         * @param value
         *
         */
        public function set htmlText(value:String):void
        {
            if (_styleSheet)
                textField.styleSheet = _styleSheet;
            textField.htmlText = transformText(value);
        }

        /**
         *
         * @return
         *
         */
        public function get htmlText():String
        {
            return textField.htmlText;
        }

        /**
         * @return int
         */
        public function    get length():int
        {
            return textField.length;
        }

        /**
         *
         * @return
         *
         */
        public function get multiline():Boolean
        {
            return textField.multiline;
        }

        /**
         *
         * @param value
         *
         */
        public function set multiline(value:Boolean):void
        {
            textField.multiline = value;
        }

        /**
         *
         * @return
         *
         */
        public function get wordWrap():Boolean
        {
            return textField.wordWrap;
        }

        /**
         *
         * @param value
         *
         */
        public function set wordWrap(value:Boolean):void
        {
            textField.wordWrap = value;
        }

        /**
         *
         * @return
         *
         */
        public function get selectable():Boolean
        {
            return textField.selectable;
        }

        /**
         *
         * @param value
         *
         */
        public function set selectable(value:Boolean):void
        {
            textField.selectable = value;
        }

        /**
         *
         * @return
         *
         */
        public function get sharpness():Number
        {
            return textField.sharpness;
        }

        /**
         *
         * @param value
         *
         */
        public function set sharpness(value:Number):void
        {
            textField.sharpness = value;
        }

        /**
         *
         * @return
         *
         */
        public function get styleSheet():StyleSheet
        {
            return _styleSheet;
        }

        /**
         *
         * @param value
         *
         */
        public function set styleSheet(value:StyleSheet):void
        {
            _styleSheet = value;
        }

        /**
         *
         * @return
         *
         */
        public function get text():String
        {
            return textField.text;
        }

        /**
         *
         * @param value
         *
         */
        public function set text(value:String):void
        {
            textField.text = transformText(value);
        }

        /**
         *
         * @return
         *
         */
        public function get thickness():Number
        {
            return textField.thickness;
        }

        /**
         *
         * @param value
         *
         */
        public function set thickness(value:Number):void
        {
            textField.thickness = value;
        }

        public function getLineMetrics(lineNumber:int):TextLineMetrics
        {
            return textField.getLineMetrics(lineNumber);
        }

        /**
         * <p>This represents align on a TextFormat.</p>
         * @param value
         *
         */
        public function set textFieldAlign(value:String):void
        {
            proxyTextFormat.align = value;
        }

        public function set fontFace(value:String):void
        {
            font = value;
        }

        public function set fontSize(value:Number):void
        {
            size = value;
        }

        public function set font(value:String):void
        {
            proxyTextFormat.font = value;
            invalidate();
        }

        public function set blockIndent(value:Object):void
        {
            proxyTextFormat.blockIndent = value;
            invalidate();
        }

        public function set bold(value:Boolean):void
        {
            proxyTextFormat.bold = value;
            invalidate();
        }

        public function set bullet(value:Object):void
        {
            proxyTextFormat.bullet = value;
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
         *
         * @param config
         *
         */
        public function Label(styleID:String, styleClass:String = "Label")
        {
            super(styleID, styleClass);
        }

        /**
         *
         * @param config
         *
         */
        override protected function init():void
        {
            // Handles any custom style logic we may want to set by default
            preStyle();

            super.init();

            //draw();
        }

        protected function preStyle():void
        {
            addListeners();
            addChild(textField);

            textField.selectable = false;
            textField.autoSize = "left";
        }

        override protected function draw():void
        {
            proxyTextFormat.align = _textAlign;

            if (textField.styleSheet)
                textField.styleSheet = null;

            // Hacked, but there has to be a better way.
            textField.defaultTextFormat = proxyTextFormat;

            textField.setTextFormat(proxyTextFormat);

            textField.styleSheet = _styleSheet;

            super.draw();
        }

        /**
         *
         *
         */
        protected function addListeners():void
        {
            textField.addEventListener(Event.CHANGE, onTextChange);
        }

        /**
         *
         * @param format
         * @param beginIndex
         * @param endIndex
         *
         */
        public function setTextFormat(format:TextFormat, beginIndex:int = - 1, endIndex:int = - 1):void
        {
            textField.setTextFormat(format, beginIndex, endIndex);
        }

        /**
         *
         * @param event
         *
         */
        protected function onTextChange(event:Event):void
        {
            event.stopPropagation();

            dispatchEvent(new Event(Event.CHANGE, true));
        }

        /**
         *
         * @param value
         * @return
         *
         */
        public static function validateAntiAliasType(value:String):String
        {
            switch (value)
            {
                case CSSProperties.ADVANCED:
                    return value;
                    break;
                default:
                    return CSSProperties.NORMAL;
                    break;
            }

            // IntelliJ was not happy that this method didn't have a return, it's a feature not a bug
            return null;
        }

        /**
         *
         * @param value
         * @return
         *
         */
        public static function validateAutoSize(value:String):String
        {
            switch (value)
            {
                case CSSProperties.LEFT:
                case CSSProperties.RIGHT:
                case CSSProperties.CENTER:
                    return value;
                    break;
                default:
                    return CSSProperties.NONE;
                    break;
            }

            // IntelliJ was not happy that this method didn't have a return, it's a feature not a bug
            return null;
        }

        public static function validateTextTransform(value:String):String
        {
            switch (value)
            {
                case CSSProperties.UPPERCASE:
                case CSSProperties.LOWERCASE:
                    return value;
                    break;
                default:
                    return CSSProperties.NONE;
            }

            // IntelliJ was not happy that this method didn't have a return, it's a feature not a bug
            return null;
        }

        protected function transformText(value:String):String
        {
            switch (_textTransform)
            {
                case CSSProperties.UPPERCASE:
                    return value.toUpperCase();
                    break;
                case CSSProperties.LOWERCASE:
                    return value.toLowerCase();
                    break;
                default:
                    return value;
            }

            // IntelliJ was not happy that this method didn't have a return, it's a feature not a bug
            return null;
        }
    }
}