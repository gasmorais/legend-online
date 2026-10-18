package org.serialize
{
   import flash.utils.describeType;
   import org.interfaces.IXmlCoder;
   
   public class XmlCoder implements IXmlCoder
   {
      
      public function XmlCoder()
      {
         super();
      }
      
      private static function encodingProperty(param1:String, param2:Object) : String
      {
         if(param2 is Array)
         {
            return "";
         }
         return escapeString(param1) + "=\"" + String(param2) + "\" ";
      }
      
      private static function escapeString(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = "";
         var _loc4_:Number = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            switch(_loc6_ = param1.charAt(_loc7_))
            {
               case "\"":
                  _loc3_ += "\\\"";
                  break;
               case "/":
                  _loc3_ += "\\/";
                  break;
               case "\\":
                  _loc3_ += "\\\\";
                  break;
               case "\b":
                  _loc3_ += "\\b";
                  break;
               case "\f":
                  _loc3_ += "\\f";
                  break;
               case "\n":
                  _loc3_ += "\\n";
                  break;
               case "\r":
                  _loc3_ += "\\r";
                  break;
               case "\t":
                  _loc3_ += "\\t";
                  break;
               default:
                  if(_loc6_ < " ")
                  {
                     _loc5_ = _loc6_.charCodeAt(0).toString(16);
                     _loc2_ = _loc5_.length == 2 ? "00" : "000";
                     _loc3_ += "\\u" + _loc2_ + _loc5_;
                  }
                  else
                  {
                     _loc3_ += _loc6_;
                  }
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:String, param2:Object) : XML
      {
         var _loc6_:Object = null;
         var _loc4_:String = "<" + param1 + " ";
         var _loc5_:XML = describeType(param2);
         if(_loc5_.@name.toString() == "Object")
         {
            for(var _loc7_:String in param2)
            {
               _loc6_ = param2[_loc7_];
               if(!(_loc6_ is Function))
               {
                  _loc4_ += encodingProperty(_loc7_,_loc6_);
               }
            }
         }
         else
         {
            for each(var _loc3_:XML in _loc5_..*.(name() == "variable" || name() == "accessor"))
            {
               _loc4_ += encodingProperty(_loc3_.@name.toString(),param2[_loc3_.@name]);
            }
         }
         _loc4_ += "/>";
         return new XML(_loc4_);
      }
      
      public function decode(param1:XML, param2:Object = null) : Object
      {
         if(!param2)
         {
            param2 = {};
         }
         for each(var _loc3_:XML in param1.attributes())
         {
            param2[String(_loc3_.name())] = String(_loc3_);
         }
         return param2;
      }
   }
}

