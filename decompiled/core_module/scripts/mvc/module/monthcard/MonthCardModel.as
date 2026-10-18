package mvc.module.monthcard
{
   public class MonthCardModel
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var giftList:Array;
      
      public var openChange:Boolean = false;
      
      public function MonthCardModel()
      {
         super();
         giftList = [];
      }
      
      public function get hasReward() : Boolean
      {
         for each(var _loc1_:MonthCardGiftInfo in giftList)
         {
            if(_loc1_.canGetReward)
            {
               return true;
            }
         }
         return false;
      }
   }
}

