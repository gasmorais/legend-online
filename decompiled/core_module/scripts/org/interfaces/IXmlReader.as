package org.interfaces
{
   public interface IXmlReader
   {
      
      function parse(param1:XML, param2:IXmlCoder) : void;
      
      function putItem(param1:String, param2:String) : void;
      
      function getItem(param1:String) : Object;
      
      function getString(param1:String) : String;
      
      function getInt(param1:String) : int;
      
      function getUint(param1:String) : uint;
      
      function getNumber(param1:String) : Number;
      
      function getBoolean(param1:String) : Boolean;
   }
}

