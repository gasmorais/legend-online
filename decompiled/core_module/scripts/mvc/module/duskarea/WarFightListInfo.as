package mvc.module.duskarea
{
   import map.campaign.data.WarFightOrderInfo;
   import yishi.manager.PlayerManager;
   
   public class WarFightListInfo
   {
      
      public var one_teamId:int;
      
      public var two_teamId:int;
      
      public var thd_temaId:int;
      
      public var warInfoList:Array = [];
      
      public function WarFightListInfo()
      {
         super();
      }
      
      public function get selfWarInfo() : WarFightOrderInfo
      {
         var _loc2_:int = 0;
         var _loc1_:WarFightOrderInfo = new WarFightOrderInfo();
         _loc2_ = 0;
         while(_loc2_ < warInfoList.length)
         {
            if(WarFightOrderInfo(warInfoList[_loc2_]).userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
            {
               _loc1_ = warInfoList[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

