package org.serialize.jsion
{
   import flash.utils.describeType;
   
   public class JSONEncoder
   {
      
      private var jsonString:String;
      
      public function JSONEncoder(param1:*)
      {
         super();
         jsonString = convertToString(param1);
      }
      
      public function getString() : String
      {
         return jsonString;
      }
      
      private function convertToString(param1:*) : String
      {
         var _loc2_:Number = NaN;
         if(param1 is String)
         {
            return escapeString(param1 as String);
         }
         if(param1 is Number)
         {
            _loc2_ = param1 as Number;
            return isFinite(param1 as Number) ? _loc2_.toString() : "null";
         }
         if(param1 is Boolean)
         {
            return param1 ? "true" : "false";
         }
         if(param1 is Array)
         {
            return arrayToString(param1 as Array);
         }
         if(param1 is Object && param1 != null)
         {
            return objectToString(param1);
         }
         return "null";
      }
      
      private function escapeString(param1:String) : String
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
         return "\"" + _loc3_ + "\"";
      }
      
      private function arrayToString(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += ",";
            }
            _loc2_ += convertToString(param1[_loc3_]);
            _loc3_++;
         }
         return "[" + _loc2_ + "]";
      }
      
      private function objectToString(param1:Object) : String
      {
         var _loc5_:Object = null;
         var _loc3_:String = "";
         var _loc2_:XML = describeType(param1);
         if(_loc2_.@name.toString() == "Object")
         {
            for(var _loc6_:String in param1)
            {
               _loc5_ = param1[_loc6_];
               if(!(_loc5_ is Function))
               {
                  if(_loc3_.length > 0)
                  {
                     _loc3_ += ",";
                  }
                  _loc3_ += escapeString(_loc6_) + ":" + convertToString(_loc5_);
               }
            }
         }
         else
         {
            for each(var _loc4_:XML in _loc2_..*.(name() == "variable" || name() == "accessor"))
            {
               if(_loc3_.length > 0)
               {
                  _loc3_ += ",";
               }
               _loc3_ += escapeString(_loc4_.@name.toString()) + ":" + convertToString(param1[_loc4_.@name]);
            }
         }
         return "{" + _loc3_ + "}";
      }
   }
}

