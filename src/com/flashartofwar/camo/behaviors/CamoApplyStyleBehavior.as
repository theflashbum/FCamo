package com.flashartofwar.camo.behaviors
{
    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.behaviors.ApplyStyleBehavior;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;

    public class CamoApplyStyleBehavior extends ApplyStyleBehavior
    {
        protected var _styleClass:String;
        public var refreshNeeded:Boolean = false;

        public function CamoApplyStyleBehavior(target:Object, applicator:IApplicator, styleSheet:IStyleSheet, styleID:String, styleClass:String = null)
        {
            super(target, applicator, styleSheet, styleID, styleClass);
        }

        public function set styleID(value:String):void
        {
            _id = value;
            refreshNeeded = true;
        }

        public function get styleID():String
        {
            return _id;
        }
        
        public function set styleClass(value:String):void
        {
            _styleClass = value;
            refreshNeeded = true;
        }

        public function get styleClass():String
        {
            return _styleClass
        }
        /**
         * This method will reparse the styleID and styleClass selectors.
         */
        public function refresh():void
        {
            refreshNeeded = false;
            _defaultStyleNames.length = 0;
            parseStyleNames(_id, _styleClass);
            applyDefaultStyle();
        }
    }
}