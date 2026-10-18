package mvc.module.monthcard
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.StringHelper;
   
   public class MonthCardGiftInfo
   {
      
      public var type:int;
      
      public var giftName:String;
      
      public var giftPic:String;
      
      public var needPoint:int;
      
      public var lastDay:int;
      
      public var leftDay:int;
      
      public var itemList:Array;
      
      public var collectTime:String = null;
      
      public function MonthCardGiftInfo()
      {
         super();
         itemList = [];
      }
      
      public function get hasBuy() : Boolean
      {
         return leftDay >= 0;
      }
      
      public function get canGetReward() : Boolean
      {
         if(!hasBuy || leftDay <= 0)
         {
            return false;
         }
         if(StringHelper.isNullOrEmpty(collectTime))
         {
            return false;
         }
         var _loc2_:Date = DateFormatter.parse(collectTime,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Date = playerModel.sysCurtime;
         if(_loc1_.fullYear == _loc2_.fullYear && _loc1_.month == _loc2_.month && _loc1_.date == _loc2_.date)
         {
            return false;
         }
         return true;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

