package com.flashartofwar.camo.layout
{
    import com.flashartofwar.camo.display.CamoDisplay;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;

    public class AbstractLayout extends CamoDisplay implements ILayout
    {

        protected var maxWidth:Number = 0;
        protected var maxHeight:Number = 0;

        protected var internalPoint:Point = new Point();

        public function AbstractLayout(self:AbstractLayout, styleID:String, styleClass:String = "CamoDisplay")
        {

            if (self == this)
            {
                super(styleID, styleClass);
            }
            else
            {
                throw new Error("AbstractDisplay can not be directly Instantiated");
            }

        }

        public function measure(target:DisplayObjectContainer):void
        {

            if (!target) target = display;

            var total:int = display.numChildren;
            var i:int;
            var child:DisplayObject;
            var tempW:Number = 0;
            var tempH:Number = 0;

            for (i = 0; i < total; ++i)
            {
                child = display.getChildAt(i);

                tempW = child.width;
                tempH = child.height;


                if (child is CamoDisplay)
                {
                    tempW += CamoDisplay(child).marginLeft + CamoDisplay(child).marginRight;
                    tempH += CamoDisplay(child).marginTop + CamoDisplay(child).marginBottom;
                }

                if (tempW > maxWidth)
                    maxWidth = tempW;

                if (tempH > maxHeight)
                    maxHeight = tempH;

            }
        }

        public function layout(target:DisplayObjectContainer):void
        {
            if (!target) target = display;
        }

        public function findCenter(target:DisplayObject, w:Number, h:Number):Point
        {


            return internalPoint;
        }
    }
}