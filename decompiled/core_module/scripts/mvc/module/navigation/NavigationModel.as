package mvc.module.navigation
{
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class NavigationModel
   {
      
      public var strength:int;
      
      public var currency:int = 2;
      
      public var hasBuyShopNum:int;
      
      public var hasBuyStrengthNum:int;
      
      public var shopRefreshTime:Number;
      
      public var hasInviteNum:int;
      
      public var hasAssistNum:int;
      
      public var shopList:Array;
      
      public var portList:Array;
      
      public var boatList:Array;
      
      public var fishOpen:Boolean;
      
      public var hasFishingTime:int;
      
      public var fishRewardList:Array;
      
      private var _selectedBoatInfo:NavigationBoatInfo;
      
      private var _fishingInterval:int;
      
      private var _fishingMaxCount:int;
      
      public var op:int = -1;
      
      public function NavigationModel()
      {
         super();
         shopList = [];
         portList = [];
         boatList = [];
         fishRewardList = [];
         _fishingInterval = ConfigInfoManager.instance.getNavigationFishingInterval();
         _fishingMaxCount = ConfigInfoManager.instance.getNavigationFishingRewardMax();
      }
      
      public function getBoatInfoByBoatId(param1:String) : NavigationBoatInfo
      {
         if(param1 == null)
         {
            return null;
         }
         for each(var _loc2_:NavigationBoatInfo in boatList)
         {
            if(_loc2_.boatId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPortInfoByPortId(param1:String) : NavigationPortInfo
      {
         if(param1 == null)
         {
            return null;
         }
         for each(var _loc2_:NavigationPortInfo in portList)
         {
            if(_loc2_.boatId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selectedBoatInfo() : NavigationBoatInfo
      {
         return _selectedBoatInfo;
      }
      
      public function set selectedBoatInfo(param1:NavigationBoatInfo) : void
      {
         if(_selectedBoatInfo == param1)
         {
            return;
         }
         _selectedBoatInfo = param1;
         MsgMan.notifyObserver("NAVIGATION_BOAT_CHANGE");
      }
      
      public function get fishingPartTime() : String
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Array = ConfigInfoManager.instance.getNavigationFishingTime();
         var _loc9_:Array = LogicUtils.configPartTime(_loc7_);
         var _loc3_:Number = playerModel.sysCurTimeBySecond;
         var _loc1_:* = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc9_.length)
         {
            _loc4_ = _loc7_[_loc6_].split(",");
            _loc5_ = Number(_loc4_[0]);
            _loc8_ = Number(_loc4_[0]);
            if(_loc3_ < _loc5_ || _loc3_ < _loc8_)
            {
               _loc1_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         var _loc2_:String = _loc7_[_loc1_];
         return StringHelper.replaceStr(_loc2_,",","--");
      }
      
      public function get fishingPartShowTime() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = null;
         var _loc3_:Array = ConfigInfoManager.instance.getNavigationFishingTime();
         var _loc4_:String = "";
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = StringHelper.replaceStr(_loc3_[_loc2_],",","--");
            _loc4_ += _loc1_ + "\n";
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get isBoatFishing() : Boolean
      {
         if(!fishOpen)
         {
            return false;
         }
         for each(var _loc1_:NavigationBoatInfo in boatList)
         {
            if(_loc1_.state == 4)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get noFishingCount() : Boolean
      {
         var _loc1_:int = hasFishingTime / _fishingInterval;
         return _loc1_ >= _fishingMaxCount;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

