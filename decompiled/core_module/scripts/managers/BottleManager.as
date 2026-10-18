package managers
{
   import com.road.yishi.proto.bottle.BottleMsg;
   import com.road.yishi.proto.bottle.BottleScoreMsg;
   import com.road.yishi.proto.bottle.PlayerBottleMsg;
   import com.road.yishi.proto.item.BottleDropListMsg;
   import com.road.yishi.proto.item.BottleOpMsg;
   import com.road.yishi.proto.item.BottlePassMsg;
   import events.BottleEvent;
   import flash.events.EventDispatcher;
   import mvc.module.bottle.BottleModel;
   import mvc.module.bottle.BottleUserInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class BottleManager extends EventDispatcher
   {
      
      private static var _instance:BottleManager;
      
      public var openBottle:Boolean;
      
      public var BOTTLE_END_DATE:Date;
      
      private var _model:BottleModel;
      
      public function BottleManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : BottleManager
      {
         if(!_instance)
         {
            _instance = new BottleManager();
         }
         return _instance;
      }
      
      public function get model() : BottleModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new BottleModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4497,__updateBottleInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4526,__updateBottleResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 295,__updateBottleData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4825,__updateBottleUserInfomation);
      }
      
      private function __updateBottleInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottlePassMsg = new BottlePassMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottlePassMsg;
         if(_loc2_.passType == 1)
         {
            if(model.bottleRewardsInfo)
            {
               model.bottleRewardsInfo = model.bottleRewardsInfo.concat(_loc2_.infos);
            }
            else
            {
               model.bottleRewardsInfo = _loc2_.infos;
            }
         }
         else if(_loc2_.passType == 2)
         {
            model.bottleLuckShowInfo = _loc2_.infos;
         }
      }
      
      private function __updateBottleResult(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottleScoreMsg = new BottleScoreMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BottleScoreMsg;
         var _loc3_:int = _loc2_.count - model.openCount;
         model.openCount = _loc2_.count;
         model.boxMarkStr = _loc2_.treeStatus;
         model.isOpenFrame = _loc2_.openView;
         dispatchEvent(new BottleEvent("CT__UPDATE_BOX_STATUS",{
            "addCount":_loc3_,
            "alert":_loc2_.alterBottle
         }));
      }
      
      private function __updateBottleData(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottleDropListMsg = new BottleDropListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BottleDropListMsg;
         if(_loc2_.dropItem && _loc2_.dropItem.length > 0)
         {
            model.bottleShowItemInfo = _loc2_.dropItem;
         }
         if(_loc2_.score && _loc2_.score.length > 0)
         {
            model.countRewardArr = _loc2_.score;
            model.countRewardArr.sortOn("param",16);
         }
         if(_loc2_.storey && _loc2_.storey.length > 0)
         {
            model.floorRewardArr = _loc2_.storey;
            model.floorRewardArr.sortOn("param",16);
         }
         if(model.hasOpenFrame)
         {
            FrameControllerManager.instance.openControllerByInfo("bottle");
         }
         BOTTLE_END_DATE = DateFormatter.parse(_loc2_.endTime,"YYYY-MM-DD hh:mm:ss");
         if(_loc2_.open && PlayerManager.instance.currentPlayerModel.nowDate < BOTTLE_END_DATE.time)
         {
            openBottle = true;
         }
         else
         {
            openBottle = false;
         }
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function sendOpenInfo(param1:int = 0, param2:int = 0, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(8604);
         var _loc4_:BottleOpMsg = new BottleOpMsg();
         _loc4_.alterType = param2;
         _loc4_.opType = param1;
         if(param3)
         {
            _loc4_.stickFirst = 0;
         }
         else
         {
            _loc4_.stickFirst = 1;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      private function __updateBottleUserInfomation(param1:SLGSocketEvent) : void
      {
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:BottleUserInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:BottleMsg = new BottleMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as BottleMsg;
         var _loc7_:int = parseInt(model.getHeightArray()[4]);
         if(model.nowLayer < _loc7_ || _loc2_.total <= _loc7_)
         {
            model.nowLayer = _loc2_.total <= _loc7_ ? _loc2_.total : _loc7_;
         }
         _loc5_ = _loc2_.playerBottle;
         _loc4_ = int(_loc5_.length);
         model.userArray = new Vector.<BottleUserInfo>(5);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = new BottleUserInfo();
            _loc3_.userId = (_loc5_[_loc6_] as PlayerBottleMsg).userId;
            _loc3_.userName = (_loc5_[_loc6_] as PlayerBottleMsg).nickName;
            _loc3_.isVip = (_loc5_[_loc6_] as PlayerBottleMsg).isVip;
            _loc3_.state = (_loc5_[_loc6_] as PlayerBottleMsg).state;
            model.userArray[_loc6_] = _loc3_;
            _loc6_++;
         }
         dispatchEvent(new BottleEvent("UPDATE_REWARD_USERINFO"));
      }
   }
}

