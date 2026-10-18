package mvc.module.landmine
{
   import events.LandMineEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.SimpleDictionary;
   
   public class LandMineModel extends EventDispatcher
   {
      
      public var isDraging:Boolean = false;
      
      public var sapperDic:SimpleDictionary;
      
      public var posX:int = -1;
      
      public var posY:int = -1;
      
      public var state:int = 0;
      
      public var winnerId:int = 0;
      
      public var isWin:Boolean = false;
      
      public var rewardCount:int = 0;
      
      private var _maxRewardCount:int = 0;
      
      private var _itemsIdArray:Array = [];
      
      private var _itemsCountArray:Array = [];
      
      public function LandMineModel()
      {
         super();
         sapperDic = new SimpleDictionary();
         _maxRewardCount = ConfigInfoManager.instance.getLandMineMaxRewardCount();
         parseItems();
      }
      
      private function parseItems() : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = ConfigInfoManager.instance.getLandMineItems();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = String(_loc1_[_loc3_]);
            _loc4_ = _loc5_.split(",");
            _loc6_ = int(_loc4_[0]);
            _loc2_ = int(_loc4_[1]);
            _itemsIdArray.push(_loc6_);
            _itemsCountArray.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function get maxRewardCount() : int
      {
         return _maxRewardCount;
      }
      
      public function get itemsIdArray() : Array
      {
         return _itemsIdArray;
      }
      
      public function get itemsCountArray() : Array
      {
         return _itemsCountArray;
      }
      
      public function get hasRewardCount() : Boolean
      {
         var _loc1_:Boolean = false;
         if(maxRewardCount - rewardCount > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function leave(param1:LandMineSapperInfo) : void
      {
         dispatchEvent(new LandMineEvent("SAPPER_LEAVE",param1));
      }
      
      public function move(param1:LandMineSapperInfo) : void
      {
         dispatchEvent(new LandMineEvent("SAPPER_MOVE",param1));
      }
      
      public function end() : void
      {
         dispatchEvent(new LandMineEvent("GAME_END",this));
      }
      
      public function cancel() : void
      {
         dispatchEvent(new LandMineEvent("TEAM_CANCEL",this));
      }
      
      public function commit() : void
      {
         dispatchEvent(new LandMineEvent("INFO_UPDATE",this));
      }
   }
}

