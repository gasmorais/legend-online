package yishi.utils
{
   public class ClassFactory
   {
      
      private static var _dateNum:int = 0;
      
      public function ClassFactory()
      {
         super();
      }
      
      public static function createInstance(param1:Class, param2:Object) : *
      {
         var _loc4_:Object = new param1();
         if(param2 != null)
         {
            for(var _loc3_:String in param2)
            {
               if(_loc4_[_loc3_] is Date)
               {
                  _loc4_[_loc3_] = copyDateType(param2[_loc3_]);
               }
               else
               {
                  _loc4_[_loc3_] = param2[_loc3_];
               }
            }
         }
         return _loc4_;
      }
      
      public static function createInstanceII(param1:Class, param2:Object, param3:XML) : *
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc4_:Object = new param1();
         for each(var _loc6_:XML in param3..*.(name() == "variable" || name() == "accessor"))
         {
            if(_loc6_.@access == "readonly")
            {
               continue;
            }
            _loc5_ = _loc6_.@type;
            _loc7_ = _loc6_.@name;
            switch(_loc5_)
            {
               case "Boolean":
                  _loc4_[_loc7_] = sloveBooble(param2[_loc7_]);
                  break;
               case "int":
                  _loc4_[_loc7_] = int(param2[_loc7_]);
                  break;
               case "Number":
                  _loc4_[_loc7_] = Number(param2[_loc7_]);
                  break;
               case "uint":
                  _loc4_[_loc7_] = uint(param2[_loc7_]);
                  break;
               case "String":
                  _loc4_[_loc7_] = String(param2[_loc7_]);
                  break;
               case "Date":
                  _dateNum = _dateNum + 1;
                  _loc4_[_loc7_] = copyDateType(param2[_loc7_]);
            }
         }
         return _loc4_;
      }
      
      public static function createInstanceIII(param1:Class, param2:XML) : *
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:Object = new param1();
         for each(var _loc4_:XML in param2.attributes())
         {
            _loc5_ = String(_loc4_.name());
            if(_loc3_.hasOwnProperty(_loc5_))
            {
               _loc6_ = String(_loc4_);
               if(_loc6_ == "true")
               {
                  _loc3_[_loc5_] = true;
               }
               else if(_loc6_ == "false")
               {
                  _loc3_[_loc5_] = false;
               }
               else
               {
                  _loc3_[_loc5_] = _loc6_;
               }
            }
         }
         return _loc3_;
      }
      
      public static function parse(param1:Class, param2:Object) : *
      {
         var _loc3_:Object = new param1();
         for(var _loc4_:String in param2)
         {
            if(_loc3_.hasOwnProperty(_loc4_))
            {
               _loc3_[_loc4_] = param2[_loc4_];
            }
         }
         return _loc3_;
      }
      
      private static function sloveBooble(param1:*) : Boolean
      {
         if(param1 is String)
         {
            if(String(param1) == "true")
            {
               return true;
            }
            if(String(param1) == "false")
            {
               return false;
            }
            return Boolean(param1);
         }
         return Boolean(param1);
      }
      
      public static function copyDateType(param1:Object) : Date
      {
         var _loc2_:Date = null;
         if(!param1)
         {
            return null;
         }
         if(param1.hasOwnProperty("year"))
         {
            _loc2_ = new Date(param1["year"],param1["month"] - 1,param1["day"],param1["hour"],param1["minute"],param1["second"]);
         }
         else
         {
            _loc2_ = DateFormatter.parse(param1.toString(),"YYYY-MM-DD hh:mm:ss");
         }
         return _loc2_;
      }
   }
}

