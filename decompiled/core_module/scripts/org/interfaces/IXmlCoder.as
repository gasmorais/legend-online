package org.interfaces
{
   public interface IXmlCoder
   {
      
      function encode(param1:String, param2:Object) : XML;
      
      function decode(param1:XML, param2:Object = null) : Object;
   }
}

