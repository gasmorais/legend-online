package yishi.utils
{
   public class PageUtils
   {
      
      public function PageUtils()
      {
         super();
      }
      
      public static function getTotalPages(param1:Object, param2:int = 10) : int
      {
         if(param1)
         {
            return Math.ceil(param1.length / param2);
         }
         return 0;
      }
      
      public static function getTargetPageList(param1:Object, param2:int = 1, param3:int = 10) : Object
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc6_ = int(param1.length);
            _loc5_ = Math.ceil(_loc6_ / param3);
            if(param2 > 0 && param2 <= _loc5_)
            {
               _loc4_ = int(param2 * param3 > _loc6_ ? _loc6_ : param2 * param3);
               return param1.slice((param2 - 1) * param3,_loc4_);
            }
         }
         return null;
      }
   }
}

