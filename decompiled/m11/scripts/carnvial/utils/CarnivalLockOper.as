package carnvial.utils
{
   public class CarnivalLockOper
   {
      
      private static var _ins:CarnivalLockOper;
      
      private var _callBack:Function;
      
      public function CarnivalLockOper()
      {
         super();
      }
      
      public static function get Ins() : CarnivalLockOper
      {
         if(_ins == null)
         {
            _ins = new CarnivalLockOper();
         }
         return _ins;
      }
      
      public function regist(param1:Function) : void
      {
         _callBack = param1;
      }
      
      public function unRegist() : void
      {
         _callBack = null;
      }
      
      public function doCall(... rest) : void
      {
         if(_callBack != null)
         {
            _callBack.apply(null,rest);
         }
      }
   }
}

