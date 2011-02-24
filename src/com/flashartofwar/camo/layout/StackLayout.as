package com.flashartofwar.camo.layout
{
    import com.flashartofwar.fboxmodel.FBoxModel;
    import com.flashartofwar.fcss.enum.CSSProperties;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;

    public class StackLayout extends AbstractLayout
    {

        public static const VERTICAL:String = "y";
        public static const HORIZONTAL:String = "x";

        private const WIDTH:String = "width";
        private const HEIGHT:String = "height";

        private var dirProp:String = HORIZONTAL;
        private var sizeProp:String = WIDTH;
        private var marginSideA:String;
        private var marginSideB:String;

        protected function set direction(value:String):void
        {
            switch (value)
            {
                case VERTICAL:
                    dirProp = VERTICAL;
                    sizeProp = HEIGHT;
                    marginSideA = CSSProperties.MARGIN_TOP;
                    marginSideB = CSSProperties.MARGIN_BOTTOM;

                    break;
                default:
                    dirProp = HORIZONTAL;
                    sizeProp = WIDTH;
                    marginSideA = CSSProperties.MARGIN_LEFT;
                    marginSideB = CSSProperties.MARGIN_RIGHT;
                    break;
            }

            invalidate();
        }

        public function StackLayout(styleID:String, styleClass:String = "StackLayout", direction:String = VERTICAL)
        {
            super(this, styleID, styleClass);
            this.direction = direction;
        }

        override protected function init():void
        {
            addEventListener(FBoxModel.DRAW, onBoxModelDraw);
            super.init();
        }

        private function onBoxModelDraw(event:Event):void
        {
            invalidate();
        }

        override public function layout(target:DisplayObjectContainer):void
        {

            var total:int = target.numChildren;
            var i:int;
            var nextCoord:Number = 0;
            var child:DisplayObject;

            for (i = 0; i < total; i ++)
            {
                child = target.getChildAt(i);

                child[dirProp] = nextCoord;
                nextCoord += child[sizeProp];

            }
        }

        override protected function draw():void
        {
            measure(display);
            layout(display);
            super.draw();
        }
    }
}