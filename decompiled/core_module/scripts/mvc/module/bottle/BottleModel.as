package mvc.module.bottle
{
   import events.BottleEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   
   public class BottleModel extends EventDispatcher
   {
      
      private var _bottleRewardsInfo:Array;
      
      private var _bottleLuckShowInfo:Array;
      
      private var _bottleLayerShowInfo:Array;
      
      private var _bottleShowItemInfo:Array;
      
      private var _bottleRefuseInvite:Boolean;
      
      private var _bottleRefuseTeamInvite:Boolean;
      
      private var _bottleRefuseInvitation:Boolean;
      
      private var _boxMarkStr:String;
      
      public var openCount:int;
      
      private var _nowLayer:int;
      
      private var _userArray:Vector.<BottleUserInfo> = new Vector.<BottleUserInfo>(5);
      
      private var _isOpenFrame:Boolean;
      
      public var clickBoxIndex:int;
      
      public var boutiqueGoodsArr:Array = [];
      
      public var countRewardArr:Array = [];
      
      public var floorRewardArr:Array = [];
      
      public var hasOpenFrame:Boolean = false;
      
      public function BottleModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function set bottleRewardsInfo(param1:Array) : void
      {
         _bottleRewardsInfo = param1;
         dispatchEvent(new BottleEvent("UPDATE_REWARDS_INFO"));
      }
      
      public function get bottleRewardsInfo() : Array
      {
         return _bottleRewardsInfo;
      }
      
      public function getHeightArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [0,0,0,0,0];
         if(!floorRewardArr)
         {
            return _loc1_;
         }
         _loc2_ = 0;
         while(_loc2_ < floorRewardArr.length)
         {
            _loc1_[_loc2_] = floorRewardArr[_loc2_].param;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getCountArray() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [0,0,0,0,0];
         if(!countRewardArr)
         {
            return _loc2_;
         }
         _loc1_ = 0;
         while(_loc1_ < countRewardArr.length)
         {
            _loc2_[_loc1_] = countRewardArr[_loc1_].param;
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function set bottleLuckShowInfo(param1:Array) : void
      {
         _bottleLuckShowInfo = param1;
         dispatchEvent(new BottleEvent("UPDATE_LUCK_SHOW_INFO"));
      }
      
      public function get bottleLuckShowInfo() : Array
      {
         return _bottleLuckShowInfo;
      }
      
      public function get bottleRefuseInvite() : Boolean
      {
         return _bottleRefuseInvite;
      }
      
      public function set bottleRefuseInvite(param1:Boolean) : void
      {
         _bottleRefuseInvite = param1;
      }
      
      public function get bottleRefuseInvitation() : Boolean
      {
         return _bottleRefuseInvitation;
      }
      
      public function set bottleRefuseInvitation(param1:Boolean) : void
      {
         _bottleRefuseInvitation = param1;
      }
      
      public function get bottleRefuseTeamInvite() : Boolean
      {
         return _bottleRefuseTeamInvite;
      }
      
      public function set bottleRefuseTeamInvite(param1:Boolean) : void
      {
         _bottleRefuseTeamInvite = param1;
      }
      
      public function set bottleShowItemInfo(param1:Array) : void
      {
         var _loc2_:int = 0;
         _bottleShowItemInfo = param1;
         boutiqueGoodsArr = [];
         _loc2_ = 0;
         while(_loc2_ < _bottleShowItemInfo.length)
         {
            if(_bottleShowItemInfo[_loc2_].isShow && boutiqueGoodsArr.length < 6)
            {
               boutiqueGoodsArr.push(_bottleShowItemInfo[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public function get bottleShowItemInfo() : Array
      {
         return _bottleShowItemInfo;
      }
      
      public function get boxMarkArr() : Array
      {
         if(StringHelper.isNullOrEmpty(_boxMarkStr))
         {
            _boxMarkStr = "0,0,0,0,0";
         }
         return _boxMarkStr.split(",");
      }
      
      public function set boxMarkStr(param1:String) : void
      {
         if(_boxMarkStr == param1)
         {
            return;
         }
         _boxMarkStr = param1;
      }
      
      public function get nowLayer() : int
      {
         return _nowLayer;
      }
      
      public function set nowLayer(param1:int) : void
      {
         _nowLayer = param1;
      }
      
      public function get userArray() : Vector.<BottleUserInfo>
      {
         return _userArray;
      }
      
      public function set userArray(param1:Vector.<BottleUserInfo>) : void
      {
         _userArray = param1;
      }
      
      public function get bottleLayerShowInfo() : Array
      {
         return _bottleLayerShowInfo;
      }
      
      public function set bottleLayerShowInfo(param1:Array) : void
      {
         _bottleLayerShowInfo = param1;
         dispatchEvent(new BottleEvent("UPDATE_LAYER_SHOW_INFO"));
      }
      
      public function get isOpenFrame() : Boolean
      {
         return _isOpenFrame;
      }
      
      public function set isOpenFrame(param1:Boolean) : void
      {
         _isOpenFrame = param1;
         if(!_isOpenFrame)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("bottle");
      }
   }
}

