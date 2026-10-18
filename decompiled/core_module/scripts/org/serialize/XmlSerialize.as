package org.serialize
{
   import flash.utils.describeType;
   import org.interfaces.IXmlCoder;
   import org.interfaces.IXmlReader;
   import yishi.utils.DateFormatter;
   
   public class XmlSerialize
   {
      
      public function XmlSerialize()
      {
         super();
      }
      
      public static function encode(param1:String, param2:Object, param3:IXmlCoder = null) : XML
      {
         if(param3 == null)
         {
            param3 = new XmlCoder();
         }
         return param3.encode(param1,param2);
      }
      
      public static function decode(param1:XML, param2:IXmlCoder = null) : Object
      {
         if(param2 == null)
         {
            param2 = new XmlCoder();
         }
         return param2.decode(param1);
      }
      
      public static function decodeType(param1:XML, param2:Class, param3:XML = null, param4:IXmlReader = null, param5:IXmlCoder = null) : *
      {
         if(param5 == null)
         {
            param5 = new XmlCoder();
         }
         if(param4 == null)
         {
            param4 = new XmlReader();
         }
         param4.parse(param1,param5);
         var _loc6_:Object = new param2();
         var _loc7_:XML = param3 == null ? describeType(_loc6_) : param3;
         copyProperty(param4,_loc6_,_loc7_);
         return _loc6_;
      }
      
      public static function decodeObject(param1:XML, param2:*, param3:IXmlReader = null, param4:IXmlCoder = null) : *
      {
         if(param4 == null)
         {
            param4 = new XmlCoder();
         }
         if(param3 == null)
         {
            param3 = new XmlReader();
         }
         param3.parse(param1,param4);
         copyProperty(param3,param2,describeType(param2));
         return param2;
      }
      
      private static function copyProperty(param1:IXmlReader, param2:Object, param3:XML) : void
      {
         var _loc4_:String = null;
         var _loc5_:* = param3..*.(name() == "variable" || name() == "accessor");
         for each(var _loc6_:XML in _loc5_)
         {
            switch(_loc4_ = _loc6_.@type)
            {
               case "Boolean":
                  param2[_loc6_.@name] = param1.getBoolean(_loc6_.@name);
                  break;
               case "int":
                  param2[_loc6_.@name] = param1.getInt(_loc6_.@name);
                  break;
               case "Number":
                  param2[_loc6_.@name] = param1.getNumber(_loc6_.@name);
                  break;
               case "uint":
                  param2[_loc6_.@name] = param1.getUint(_loc6_.@name);
                  break;
               case "String":
                  param2[_loc6_.@name] = param1.getString(_loc6_.@name);
                  break;
               case "Date":
                  param2[_loc6_.@name] = DateFormatter.parse(param1.getString(_loc6_.@name),"YYYY-MM-DD hh:mm:ss");
            }
         }
      }
   }
}

