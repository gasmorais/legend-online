package yishi.utils
{
   import flash.utils.describeType;
   
   public class DataUtils
   {
      
      public function DataUtils()
      {
         super();
      }
      
      public static function fillData(param1:Object, param2:Object) : void
      {
         var _loc4_:String = null;
         var _loc6_:XML = describeType(param1);
         var _loc5_:XMLList = _loc6_..variable;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = _loc3_.@name;
            param1[_loc4_] = param2[_loc4_];
         }
      }
   }
}

