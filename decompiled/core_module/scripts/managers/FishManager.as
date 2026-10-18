package managers
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.fish.CrazyFishInfoMsg;
   import com.road.yishi.proto.fish.FishInfo;
   import com.road.yishi.proto.fish.FishInfosMsg;
   import com.road.yishi.proto.fish.FishPlayer;
   import com.road.yishi.proto.fish.FishPoolMsg;
   import com.road.yishi.proto.fish.FishResultMsg;
   import com.road.yishi.proto.fish.FreshPoolMsg;
   import com.road.yishi.proto.fish.HelpOverMsg;
   import com.road.yishi.proto.fish.Result;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishPlayerInfo;
   import mvc.module.fish.FishPoolInfo;
   import mvc.module.fish.FishResultInfo;
   import mvc.module.fish.FishSigInfo;
   import mvc.module.fish.FishSigModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class FishManager
   {
      
      private static var _instance:FishManager;
      
      private var _model:FishModel;
      
      public function FishManager()
      {
         super();
         if(!_model)
         {
            _model = new FishModel();
         }
      }
      
      public static function get instance() : FishManager
      {
         if(!_instance)
         {
            _instance = new FishManager();
         }
         return _instance;
      }
      
      public function get model() : FishModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4916,__fishPoolHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4918,__fishInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4917,__fishCheckHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4919,__fishHelpOverHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4920,__fishCrazyHandler);
      }
      
      private function __fishHelpOverHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HelpOverMsg = new HelpOverMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HelpOverMsg;
         model.helpSuccess = _loc2_.result;
         model.helpOver();
      }
      
      private function __fishCrazyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CrazyFishInfoMsg = new CrazyFishInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CrazyFishInfoMsg;
         model.fishForkInfo.frame = _loc2_.frame;
         model.fishForkInfo.rotation = Int64Utils.int64ToNumber(_loc2_.angle);
         for each(var _loc3_:FishSigModel in model.fishSigsModel)
         {
            if(_loc3_.fishSigInfo.fishId == _loc2_.fishId)
            {
               _loc3_.fishSigInfo.catchState = 3;
            }
         }
         model.setAllForkState(3);
         FrameControllerManager.instance.openControllerByInfo("fish");
      }
      
      private function __fishPoolHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:FishPlayerInfo = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FishPoolMsg = new FishPoolMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FishPoolMsg;
         var _loc6_:FishPoolInfo = new FishPoolInfo();
         _loc6_.userId = _loc2_.userId;
         _loc6_.level = _loc2_.level;
         _loc6_.cdTime = Int64Utils.int64ToNumber(_loc2_.cd);
         _loc6_.score = _loc2_.score;
         _loc6_.maxCount = _loc2_.maxCount;
         if(_loc2_.hasCount)
         {
            _loc6_.count = _loc2_.count;
            InfoTipsManager.instance.updateValue(2,_loc6_.maxCount - _loc6_.count);
         }
         _loc6_.currentGp = _loc2_.gp;
         _loc6_.tool1 = _loc2_.tool1;
         _loc6_.tool2 = _loc2_.tool2;
         _loc6_.tool3 = _loc2_.tool3;
         _loc6_.tool4 = _loc2_.tool4;
         model.fishPoolInfo = _loc6_;
         model.playerList.length = 0;
         for each(var _loc5_:FishPlayer in _loc2_.fishplayers)
         {
            _loc4_ = new FishPlayerInfo();
            _loc4_.helpId = _loc5_.helpId;
            _loc4_.nickName = _loc5_.nickName;
            model.playerList.push(_loc4_);
         }
         model.fishPoolInfo.sort = _loc2_.order;
         model.fishForkInfo.type = _loc2_.hookState;
         model.commit();
      }
      
      private function __fishInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FishSigModel = null;
         var _loc4_:FishSigInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FishInfosMsg = new FishInfosMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FishInfosMsg;
         for each(var _loc6_:FishInfo in _loc2_.fishs)
         {
            if(!model.fishSigsModel[_loc6_.fishId])
            {
               _loc3_ = new FishSigModel();
            }
            else
            {
               _loc3_ = model.fishSigsModel[_loc6_.fishId];
               if(!_loc3_.fishSigInfo.isMove || _loc3_.fishSigInfo.fishState == _loc6_.state)
               {
                  continue;
               }
            }
            _loc4_ = _loc3_.fishSigInfo;
            _loc4_.fishId = _loc6_.fishId;
            _loc4_.fishState = _loc6_.state;
            _loc4_.beginTime = Int64Utils.int64ToNumber(_loc6_.beginTime);
            _loc4_.nowSysTime = Int64Utils.int64ToNumber(_loc6_.now);
            _loc4_.channelId = _loc6_.channelId;
            _loc4_.point = _loc6_.point;
            _loc4_.templateId = _loc6_.templateId;
            if(_loc4_.fishState != 4)
            {
               if(_loc4_.point)
               {
                  _loc4_.x = -(_loc4_.beginTime - _loc4_.nowSysTime) * _loc4_.fishTempInfo.Speed / 40;
               }
               else
               {
                  _loc4_.x = 830 + (_loc4_.beginTime - _loc4_.nowSysTime) * _loc4_.fishTempInfo.Speed / 40;
               }
            }
            _loc4_.y = -1;
            model.fishSigsModel.add(_loc4_.fishId,_loc3_);
         }
      }
      
      private function __fishCheckHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:FishResultInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FishResultMsg = new FishResultMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FishResultMsg;
         for each(var _loc5_:Result in _loc2_.results)
         {
            _loc3_ = new FishResultInfo();
            _loc3_.fishId = _loc5_.fishId;
            _loc3_.state = _loc5_.state;
            _loc3_.toolId = _loc5_.tool;
            model.fishResult.push(_loc3_);
         }
      }
      
      public function fishAction(param1:int, param2:Array = null) : void
      {
         var _loc4_:PackageOut = new PackageOut(9507);
         var _loc3_:FreshPoolMsg = new FreshPoolMsg();
         _loc3_.op = param1;
         if(param2)
         {
            _loc3_.paras = param2;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

