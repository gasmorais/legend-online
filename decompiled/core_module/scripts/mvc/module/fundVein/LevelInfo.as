package mvc.module.fundVein
{
   import mvc.module.fund.ActiveParmaInfo;
   
   public class LevelInfo
   {
      
      public var needPoint:int;
      
      public var isBuy:Boolean;
      
      public var infoMsg:Array = [];
      
      public var allTakedInfo:Array = [];
      
      public var level:int;
      
      public var gridTipsData:ActiveParmaInfo;
      
      public function LevelInfo()
      {
         super();
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GradeRewardInfo = null;
         _loc1_ = infoMsg.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = infoMsg.pop();
            _loc2_.clear();
            _loc1_--;
         }
         infoMsg = null;
         allTakedInfo.length = 0;
         allTakedInfo = null;
         gridTipsData = null;
      }
   }
}

