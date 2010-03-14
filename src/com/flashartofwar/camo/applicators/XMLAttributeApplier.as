package 
com.flashartofwar.camo.applicators{

	/**
	 * @author jessefreeman
	 */
	public class XMLAttributeApplier 
	{

		/**
		 * This is a list of attributes that will not be applied to an Object.
		 */
		private static const RESERVED_PROPERTIES : Object = new Object( );
		{
		RESERVED_PROPERTIES["id"] = "id";
		RESERVED_PROPERTIES["name"] = "name";
		RESERVED_PROPERTIES["class"] = "class";
		RESERVED_PROPERTIES["type"] = "type";
		RESERVED_PROPERTIES["styleid"] = "styleid";
		}

		
		/**
		 * 
		 * @param target
		 * @param attributes
		 */
		public static function applyAttributes(target : Object, attributes : XMLList) : void 
		{
			for (var i : int = 0; i < attributes.length( ); i ++)
			{
				var attName : String = String( attributes[i].name( ) );
				if(! RESERVED_PROPERTIES[attName])
				{
					
					if(target.hasOwnProperty( attName ))
					{
						target[attName] = attributes[i].toXMLString( );
					}
				}
			}
		}
	}
}
