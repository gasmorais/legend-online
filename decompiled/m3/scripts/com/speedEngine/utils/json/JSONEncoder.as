package com.speedEngine.utils.json
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
         if(param1 is String)
         {
            return escapeString(param1 as String);
         }
         if(param1 is Number)
         {
            return isFinite(param1 as Number) ? param1.toString() : "null";
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
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = "";
         var _loc4_:Number = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            switch(_loc5_ = param1.charAt(_loc7_))
            {
               case "\"":
                  _loc2_ += "\\\"";
                  break;
               case "\\":
                  _loc2_ += "\\\\";
                  break;
               case "\b":
                  _loc2_ += "\\b";
                  break;
               case "\f":
                  _loc2_ += "\\f";
                  break;
               case "\n":
                  _loc2_ += "\\n";
                  break;
               case "\r":
                  _loc2_ += "\\r";
                  break;
               case "\t":
                  _loc2_ += "\\t";
                  break;
               default:
                  if(_loc5_ < " ")
                  {
                     _loc3_ = _loc5_.charCodeAt(0).toString(16);
                     _loc6_ = _loc3_.length == 2 ? "00" : "000";
                     _loc2_ += "\\u" + _loc6_ + _loc3_;
                  }
                  else
                  {
                     _loc2_ += _loc5_;
                  }
            }
            _loc7_++;
         }
         return "\"" + _loc2_ + "\"";
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
         var _loc4_:String = "";
         var _loc3_:XML = describeType(param1);
         if(_loc3_.@name.toString() == "Object")
         {
            for(var _loc6_:String in param1)
            {
               _loc5_ = param1[_loc6_];
               if(!(_loc5_ is Function))
               {
                  if(_loc4_.length > 0)
                  {
                     _loc4_ += ",";
                  }
                  _loc4_ += escapeString(_loc6_) + ":" + convertToString(_loc5_);
               }
            }
         }
         else
         {
            for each(var _loc2_:XML in _loc3_..*.(name() == "variable" || name() == "accessor"))
            {
               if(_loc4_.length > 0)
               {
                  _loc4_ += ",";
               }
               _loc4_ += escapeString(_loc2_.@name.toString()) + ":" + convertToString(param1[_loc2_.@name]);
            }
            if(_loc3_.@isDynamic.toString() == "true")
            {
               _loc5_ = {};
               for(_loc6_ in param1)
               {
                  _loc5_ = param1[_loc6_];
                  if(!(_loc5_ is Function))
                  {
                     if(_loc4_.length > 0)
                     {
                        _loc4_ += ",";
                     }
                     _loc4_ += escapeString(_loc6_) + ":" + convertToString(_loc5_);
                  }
               }
            }
         }
         return "{" + _loc4_ + "}";
      }
   }
}

