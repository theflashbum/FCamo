package com.flashartofwar.camo.layout
{
    import flash.display.DisplayObjectContainer;

    public interface ILayout
    {

        function measure(target:DisplayObjectContainer):void;

        function layout(target:DisplayObjectContainer):void;

    }
}