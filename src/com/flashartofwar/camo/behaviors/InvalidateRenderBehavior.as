package com.flashartofwar.camo.behaviors
{
    import com.flashartofwar.camo.display.IDraw;

    import flash.events.Event;

    public class InvalidateRenderBehavior extends AbstractBehavior
    {

        private var _invalid:Boolean;

        public function InvalidateRenderBehavior(target:*)
        {
            super(target);
        }

        override public function set target(instance:*):void
        {
            if (instance is IDraw)
            {
                super.target = instance;
                addStageListeners();
            }
        }

        protected function invalidate(type:String = "all"):void
        {

            //TODO This may be expensive, need to look into removing the Try Catch
            if (!_invalid)
            {
                try
                {
                    _target.stage.invalidate();
                    _invalid = true;
                }
                catch(error:Error)
                {
                    _invalid = false;
                }
            }
        }

        protected function onAddedToStage(event:Event):void
        {
            _target.stage.addEventListener(Event.RENDER, onRender, false, 0, true);
            _target.drawNow();
        }

        protected function onRemovedFromStage(event:Event):void
        {
            _target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            _target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }

        protected function onRender(event:Event = null):void
        {
            if (_invalid)
            {
                _target.drawNow();
                _invalid = false;
            }
        }


        // Renderer

        protected function addStageListeners():void
        {
            _target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            _target.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
        }
    }
}