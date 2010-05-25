/**
 * Component.as
 * Keith Peters
 * version 0.97
 *
 * Base class for all components
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
 *
 *
 *
 * Components with text make use of the font PF Ronda Seven by Yuusuke Kamiyamane
 * This is a free font obtained from http://www.dafont.com/pf-ronda-seven.font
 */

package com.flashartofwar.camo.components
{
    import com.flashartofwar.camo.display.CamoDisplay;
    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.behaviors.ApplyStyleBehavior;
    import com.flashartofwar.fcss.behaviors.IApplyStyleBehavior;
    import com.flashartofwar.fcss.styles.IStyle;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;

    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    public class AbstractComponent extends CamoDisplay implements IApplyStyleBehavior
    {
        protected var styleBehavior:ApplyStyleBehavior;
        protected var styleID:String = "demo";
        protected var styleSheet:IStyleSheet;
        protected var applicator:IApplicator;
        protected var styleClass:String;

        /**
         * Constructor
         * @param styleID this represents the css id F*CSS will use to style the component.
         * @param parent The parent DisplayObjectContainer on which to add this component.
         * @param xpos The x position to place this component.
         * @param ypos The y position to place this component.
         */
        public function AbstractComponent(self:AbstractComponent, styleID:String, styleSheet:IStyleSheet, applicator:IApplicator, styleClass:String = "AbstractComponent")
        {

                if (self == this) {

                    this.styleID = styleID
                    this.styleClass = styleClass;

                    this.styleSheet = styleSheet;
                    this.applicator = applicator;

                    super();
                } else {
                    throw new Error("AbstractComponent can not be directly Instantiated");
                }
        }

        /**
         * Initilizes the component.
         */

        protected function addStyleBehavior():void
        {
            styleBehavior = new ApplyStyleBehavior(this, applicator, styleSheet, styleID);
        }


        override protected function init():void
        {
            super.init();
            addChildren();
            addStyleBehavior();
            //TODO this may not be needed since it will only draw when added to stage
            //invalidate();


        }

        /**
         * Overriden in subclasses to create child display objects.
         */
        protected function addChildren():void
        {

        }

        ///////////////////////////////////
        // public methods
        ///////////////////////////////////

        /**
         * Utility method to set up usual stage align and scaling.
         */
        public static function initStage(stage:Stage):void
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
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
    }
}