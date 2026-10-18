package mvc.module.chesspvp
{
   public class ChesspvpBoxInfo
   {
      
      public var pos:int;
      
      public var buffId:int;
      
      public var team:int;
      
      public var blackList:Array = [];
      
      public var whiteList:Array = [];
      
      private var _isChange:Boolean = false;
      
      public function ChesspvpBoxInfo()
      {
         super();
      }
      
      public function copyBlackList(param1:Array) : void
      {
         blackList.length = 0;
         for each(var _loc2_:int in param1)
         {
            blackList.push(_loc2_);
         }
         _isChange = true;
      }
      
      public function copyWhiteList(param1:Array) : void
      {
         whiteList.length = 0;
         for each(var _loc2_:int in param1)
         {
            whiteList.push(_loc2_);
         }
         _isChange = true;
      }
      
      public function get isChange() : Boolean
      {
         return _isChange;
      }
      
      public function set isChange(param1:Boolean) : void
      {
         _isChange = param1;
      }
   }
}

