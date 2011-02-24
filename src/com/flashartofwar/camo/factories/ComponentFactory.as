package
com.flashartofwar.camo.factories
{
    import com.flashartofwar.camo.applicators.XMLAttributeApplier;
    import com.flashartofwar.camo.display.CamoDisplay;

    import flash.utils.getDefinitionByName;

    /**
     *
     * @author jessefreeman
     */
    public class ComponentFactory
    {
        /**
         * Creates a class from XML. Also allows you to replaces tokens in XML
         * by supplying a Token Object.
         *
         * This process is not recursive.
         *
         * @param data
         * @param token
         * @return
         *
         */
        public static function createFromXML(data:XML, token:Object = null):CamoDisplay
        {
            var component:CamoDisplay;

            if (token != null)
            {
                data = replaceTokens(data, token);
            }

            var classPath:String = data.@["class"].toString();

            if (classPath)
            {

                var tempClass:Class = getDefinitionByName(classPath) as Class;

                // properties
                var id:String = data.@name;
                var styleID:String = data.@styleid;

                if (styleID == null) component = new tempClass(null);
                else component = new tempClass(styleID);
                component.name = id;

                XMLAttributeApplier.applyAttributes(component, data.attributes());

                // Has more data?
                if (component.hasOwnProperty("parseXML"))
                {
                    component["parseXML"](data);
                }
            }

            return component;
        }

        public static function createFromMXML(data:XML, token:Object = null):CamoDisplay
        {
            var component:CamoDisplay;

            if (token != null)
            {
                data = replaceTokens(data, token);
            }

            var classPath:String = String(data.name()).replace("*::", "").toString();
            trace("class", classPath);

            if (classPath)
            {
                var tempClass:Class = getDefinitionByName(classPath) as Class;
                var id:String = data.@id;
                component = new tempClass(id);

                XMLAttributeApplier.applyAttributes(component, data.attributes());

                if (component.hasOwnProperty("parseXML"))
                {
                    component["parseXML"](data);
                }
            }

            return component;
        }

        /**
         * Replaces tokens in XML and returns XML.
         *
         * @param originalXML
         * @param paramObj
         * @return
         *
         */
        protected static function replaceTokens(originalXML:XML, paramObj:Object):XML
        {
            //token structure ${tokenName}
            var myRegEx:RegExp = /\$\{([a-zA-Z0-9]+)\}/g;
            var xmlString:String = originalXML.toXMLString();
            return XML(xmlString.replace(myRegEx, function():*
            {
                return paramObj[arguments[1]];
            }));
        }
    }
}