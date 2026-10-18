package mvc.module.vip
{
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class VipInfo
   {
      
      public static const NORMAL_VIP:uint = 0;
      
      public static const ADCANCED_VIP:uint = 1;
      
      public static const TEMP_VIP:uint = 2;
      
      public var ExpirData:Date;
      
      public var IsTakeGift:Boolean;
      
      public var VipType:int;
      
      public var VipGp:int;
      
      public var VipGrade:int;
      
      public var takeGiftDate:Date;
      
      public var TakeGiftDateDaily:Date;
      
      public var IsTakeTreasureGift:Boolean;
      
      public var treasureTakeGiftDate:Date;
      
      public var IsVipAndNoExpirt:Boolean;
      
      public var VipShopLevel:int;
      
      public var VipShopExp:int;
      
      public function VipInfo()
      {
         super();
      }
      
      public function get MaxGrade() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("VIP_MAX_GRADE").ConfigValue);
      }
      
      public function isGotDailyReward() : Boolean
      {
         return TakeGiftDateDaily != null && TakeGiftDateDaily.time / 1000 > PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      public function isTempVip() : Boolean
      {
         return VipType == 2;
      }
      
      public function isGotAllVIPReward() : Boolean
      {
         var _loc1_:Boolean = IsTakeGift || IsTakeTreasureGift || !isGotDailyReward() && !isTempVip();
         return !_loc1_;
      }
   }
}

