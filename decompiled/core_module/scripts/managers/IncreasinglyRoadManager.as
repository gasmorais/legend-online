package managers
{
   import com.road.yishi.proto.demonroad.DemonRoadBossMsg;
   import com.road.yishi.proto.demonroad.DemonRoadMsg;
   import com.road.yishi.proto.demonroad.DemonRoadRewardMsg;
   import flash.events.Event;
   import mvc.module.increasingly.IncreasinglyBossInfo;
   import mvc.module.increasingly.IncreasinglyModel;
   import mvc.module.increasingly.IncreasinglyRewardsInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class IncreasinglyRoadManager
   {
      
      private static var _instance:IncreasinglyRoadManager;
      
      public static const OPEN_FRAME:int = 1;
      
      public static const BUY_ENERGY:int = 2;
      
      public static const REFRESH_REWARD:int = 3;
      
      public static const ENTER_BATTLE:int = 4;
      
      public static const MOPUP:int = 6;
      
      private var _model:IncreasinglyModel;
      
      private var _isNeedChange:Boolean;
      
      public function IncreasinglyRoadManager()
      {
         super();
         _model = new IncreasinglyModel();
      }
      
      public static function get instance() : IncreasinglyRoadManager
      {
         if(!_instance)
         {
            _instance = new IncreasinglyRoadManager();
         }
         return _instance;
      }
      
      public function get model() : IncreasinglyModel
      {
         return _model;
      }
      
      public function getData() : void
      {
         enterScene();
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 205,onInfo);
      }
      
      private function onInfo(param1:SLGSocketEvent) : void
      {
         var _loc5_:IncreasinglyBossInfo = null;
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:DemonRoadMsg = new DemonRoadMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as DemonRoadMsg;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.hasEnergy)
         {
            model.energy = _loc2_.energy;
         }
         if(_loc2_.hasLevel)
         {
            model.currentLayer = _loc2_.level;
            if(model.currentLayer > model.maxLayer)
            {
               _isNeedChange = true;
            }
            if(_isNeedChange)
            {
               model.maxLayer = model.currentLayer;
               _isNeedChange = false;
            }
         }
         if(_loc2_.hasIndex)
         {
            model.currentIndex = _loc2_.index;
         }
         if(_loc2_.hasBuyCount)
         {
            model.todayHasBuyCount = _loc2_.buyCount;
         }
         if(_loc2_.bossInfos.length > 0)
         {
            model.bossInfos = [];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.bossInfos.length)
            {
               _loc5_ = readBossInfos(_loc2_.bossInfos[_loc3_]);
               model.bossInfos.push(_loc5_);
               model.bossInfos.sortOn("index",16);
               _loc3_++;
            }
         }
         NotificationManager.instance.dispatchEvent(new Event("INCREASINGLY_ROAD_INFO"));
      }
      
      private function readBossInfos(param1:DemonRoadBossMsg) : IncreasinglyBossInfo
      {
         var _loc2_:int = 0;
         var _loc4_:IncreasinglyRewardsInfo = null;
         var _loc3_:IncreasinglyBossInfo = new IncreasinglyBossInfo();
         _loc3_.layer = param1.level;
         _loc3_.index = param1.index;
         _loc3_.resource = param1.resource;
         _loc3_.rewards = [];
         _loc2_ = 0;
         while(_loc2_ < param1.rewards.length)
         {
            _loc4_ = new IncreasinglyRewardsInfo();
            _loc4_.tempalteId = (param1.rewards[_loc2_] as DemonRoadRewardMsg).itemTempId;
            _loc4_.count = (param1.rewards[_loc2_] as DemonRoadRewardMsg).count;
            _loc3_.rewards.push(_loc4_);
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function enterScene() : void
      {
         FrameControllerManager.instance.increasinglyRoadControler.isIncreasinglyRoadFrame = true;
         SceneManager.instance.setScene("INCREASINGLY_ROAD_SCENE",null,true);
      }
      
      public function refreshCurrentLayerReward() : void
      {
         var _loc2_:PackageOut = new PackageOut(5195);
         var _loc1_:DemonRoadMsg = new DemonRoadMsg();
         _loc1_.op = 3;
         _loc1_.level = model.currentLayer;
         model.isRefresh = true;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function buyEnergy() : void
      {
         var _loc2_:PackageOut = new PackageOut(5195);
         var _loc1_:DemonRoadMsg = new DemonRoadMsg();
         _loc1_.op = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function enterBattle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5195);
         var _loc2_:DemonRoadMsg = new DemonRoadMsg();
         _loc2_.op = 4;
         _loc2_.level = model.currentLayer;
         _loc2_.index = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function resolveGoods(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(5195);
         var _loc2_:DemonRoadMsg = new DemonRoadMsg();
         _loc2_.op = 5;
         _loc2_.items = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function pageChange() : void
      {
         var _loc2_:PackageOut = new PackageOut(5195);
         var _loc1_:DemonRoadMsg = new DemonRoadMsg();
         _loc1_.op = 1;
         _loc1_.level = model.currentLayer;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function mopupBattle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5195);
         var _loc2_:DemonRoadMsg = new DemonRoadMsg();
         _loc2_.op = 6;
         _loc2_.level = model.currentLayer;
         _loc2_.index = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

