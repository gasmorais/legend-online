package org.serialize
{
   import org.interfaces.IXmlCoder;
   import org.interfaces.IXmlReader;
   
   public class XmlReader implements IXmlReader
   {
      
      internal var items:Object;
      
      public function XmlReader()
      {
         super();
         items = {};
      }
      
      public function parse(param1:XML, param2:IXmlCoder) : void
      {
         items = param2.decode(param1);
      }
      
      public function readXml(param1:XML) : void
      {
         for each(var _loc2_:XML in param1.attributes())
         {
            putItem(String(_loc2_.name()),String(_loc2_));
         }
      }
      
      public function putItem(param1:String, param2:String) : void
      {
         items[param1] = param2;
      }
      
      public function getItem(param1:String) : Object
      {
         return items[param1];
      }
      
      public function getString(param1:String) : String
      {
         var _loc2_:Object = items[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.toString();
      }
      
      public function getInt(param1:String) : int
      {
         var _loc2_:Number = parseInt(items[param1]);
         if(isNaN(_loc2_))
         {
            return 0;
         }
         return _loc2_;
      }
      
      public function getUint(param1:String) : uint
      {
         var _loc2_:Number = parseInt(items[param1]);
         if(isNaN(_loc2_))
         {
            return 0;
         }
         return uint(_loc2_);
      }
      
      public function getNumber(param1:String) : Number
      {
         var _loc2_:Number = Number(items[param1]);
         if(isNaN(_loc2_))
         {
            return 0;
         }
         return _loc2_;
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         if(items[param1] == null)
         {
            return false;
         }
         return String(items[param1]).toLowerCase() == "true";
      }
   }
}

