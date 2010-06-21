package com.flashartofwar.camo.components
{
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.events.TextEvent;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.ui.Keyboard;

    public class TextInputLabel extends Label
    {
        protected var _defaultText : String = "";
        private const SELECTED:String = "selected";

        public function TextInputLabel(styleID:String, styleClass:String = "TextInpitLabel")
        {
            super(styleID, styleClass);
        }

		public override function get tabIndex() : int
		{
			return textField.tabIndex;
		}

		public override function set tabIndex( index : int ) : void
		{
			textField.tabIndex = index;
		}

		/**
		 *
		 * @return String
		 */
		public function	get defaultText() : String
		{
			return _defaultText;
		}

		/**
		 * @private
		 */
		public function set defaultText( value : String ) : void
		{
			_defaultText = value;
			checkText( );
		}

		override protected function preStyle() : void
		{
			super.preStyle( );
			textField.type = TextFieldType.INPUT;
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.selectable = true;
		}

		override protected function addListeners() : void
		{
			super.addListeners( );
            
			textField.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			textField.addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			textField.addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
			textField.addEventListener( TextEvent.TEXT_INPUT, onTextInput );
		}

		protected function checkText() : void
		{
			if( text == "" )
				text = _defaultText;
		}

		protected function onFocusIn( event : FocusEvent ) : void
		{
            if( text == _defaultText && text != "" )
				text = "";
            applyDefaultStyle(SELECTED);
		}

		protected function onFocusOut( event : FocusEvent ) : void
		{
			checkText( );
            applyDefaultStyle();
		}

		protected function onKeyDown( event : KeyboardEvent ) : void
		{
			if( event.keyCode == Keyboard.ENTER )
			{
				dispatchEvent( new Event( Event.SELECT, true ) );
			}
		}

		protected function onTextInput( event : TextEvent ) : void
		{
			event.stopPropagation( );
			dispatchEvent( new TextEvent( TextEvent.TEXT_INPUT, true, false, event.text ) );
		}

        public function set displayAsPassword(value:Boolean):void
        {
            textField.displayAsPassword = value;
        }
    }
}