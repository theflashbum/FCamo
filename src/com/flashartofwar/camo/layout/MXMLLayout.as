package
com.flashartofwar.camo.layout{
    import com.flashartofwar.camo.components.AbstractComponent;
    import com.flashartofwar.camo.factories.ComponentFactory;

    import com.flashartofwar.fcss.applicators.IApplicator;
    import com.flashartofwar.fcss.stylesheets.IStyleSheet;

    import flash.display.DisplayObject;

    /**
	 * @author Clemente Gomez - www.kreativeking.com
	 */
	public class MXMLLayout extends AbstractComponent
	{
		protected var _instanceByName : Array = [];
		protected var _instances : Array = [];

		/**
		 * 
		 */
		public function MXMLLayout(styleID:String, styleSheet:IStyleSheet, applicator:IApplicator, styleClass:String = "MXMLLayout")
		{
			super( this, styleID, styleSheet, applicator, styleClass );
		}

		public function parseMXML(mxml : XML) : void 
		{
			var groups : XMLList = XMLList( mxml.children( )[0] ).children( );
			var item : XML;
//			var regEx : RegExp = /([\*\:])*/ig;
//			var string : String;
			
			for each(item in groups)
			{
//				string = String( item.name( ) ).replace( regEx, "" );
//				trace( string );
//				trace( item.attributes( ) );
				var component : DisplayObject = ComponentFactory.createFromMXML( item );
				
				if(component)
				{
					if(component is DisplayObject)
					{
						addChild( component );
					}
						
					if(component.hasOwnProperty( "id" )) _instanceByName[component["id"]] = component;
					_instances.push( component );
				}
			}
		}

		public function get instanceByName() : Array 
		{
			return _instanceByName;
		}

		public function get instances() : Array 
		{
			return _instances.slice( );
		}
	}
}