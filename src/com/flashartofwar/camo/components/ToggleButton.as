package com.flashartofwar.camo.components{
	
    import com.flashartofwar.camo.enum.ComponentState;

    public class ToggleButton extends LabelButton implements ISelectable
    {
		private var _selected:Boolean;

        public function ToggleButton(styleID:String, styleClass:String = "ToggleButton")
        {
            super(styleID, styleClass);
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(value:Boolean):void
        {
           if(_selected == value) return;
			_selected = value;
        }

        override public function applyDefaultStyle(pseudoSelector:String = null):void
        {
	        //toggle
            if(pseudoSelector == ComponentState.SELECTED)
            {
                selected = !selected;
	            if(!selected)
	            {
		            //moving to deselected initiates a state change back to default (AKA, "toggling")
		            pseudoSelector = ComponentState.DEFAULT;
	            }
            }

	        //handle selected and over/down/up
            if (selected && pseudoSelector && pseudoSelector != ComponentState.SELECTED)
            {
                pseudoSelector = ComponentState.SELECTED + "_" + pseudoSelector;
            }

	        //handle selected and out
	        //changing from selected_over->null would undesirably clear the selected style
	        if(selected && !pseudoSelector)
	        {
		        pseudoSelector = ComponentState.SELECTED;
	        }

	        trace(this.name,  pseudoSelector);
            super.applyDefaultStyle(pseudoSelector);
        }

    }
}

