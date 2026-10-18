package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.module.LandMineMsg;
   import com.road.yishi.proto.module.SapperMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import managers.GameHallManager;
   import mvc.module.landmine.LandMineModel;
   import mvc.module.landmine.LandMineSapperInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class LandMineManager
   {
      
      private static var _instance:LandMineManager;
      
      private var _model:LandMineModel;
      
      private const OP_ENTER:int = 0;
      
      private const OP_LEAVE:int = 1;
      
      private const OP_MOVE:int = 2;
      
      private const OP_END:int = 3;
      
      private const OP_TEAM:int = 4;
      
      private const OP_REWARD_COUNT:int = 5;
      
      private const OP_CANCEL:int = 6;
      
      public function LandMineManager()
      {
         super();
         _model = new LandMineModel();
      }
      
      public static function get instance() : LandMineManager
      {
         if(!_instance)
         {
            _instance = new LandMineManager();
         }
         return _instance;
      }
      
      public function get model() : LandMineModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4882,__landmineInfoHandler);
      }
      
      private function __landmineInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:LandMineSapperInfo = null;
         var _loc6_:* = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:LandMineMsg = new LandMineMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as LandMineMsg;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_loc2_.op == OP_ENTER)
         {
            model.sapperDic.clear();
            for each(_loc6_ in _loc2_.sappers)
            {
               _loc4_ = new LandMineSapperInfo();
               _loc4_.userId = _loc6_.userId;
               _loc4_.nickName = _loc6_.nickName;
               _loc4_.arm = _loc6_.arm;
               _loc4_.cloth = _loc6_.cloth;
               _loc4_.wing = _loc6_.wing;
               _loc4_.hat = _loc6_.hat;
               _loc4_.fashionArm = _loc6_.fashionArm;
               _loc4_.fashionCloth = _loc6_.fashionCloth;
               _loc4_.hide = _loc6_.hide;
               _loc4_.posX = _loc6_.posX;
               _loc4_.posY = _loc6_.posY;
               _loc4_.state = _loc6_.state;
               _loc4_.sex = _loc6_.sex;
               _loc4_.job = _loc6_.job;
               _loc4_.templateId = _loc6_.templateId;
               _loc4_.isDragonTalker = _loc6_.isDragonTalker;
               _loc4_.battleBeastId = _loc6_.battleBeastId;
               model.sapperDic.add(_loc4_.userId,_loc4_);
            }
            FrameControllerManager.instance.openControllerByInfo("landmine");
         }
         else if(_loc2_.op == 1)
         {
            if(_loc2_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               model.posX = -1;
               model.posY = -1;
               model.state = 0;
               FrameControllerManager.instance.landMineController.closeFrame();
               if(GameHallManager.instance.model.selfTeam)
               {
                  GameHallManager.instance.enterGameHallScene();
               }
            }
            else
            {
               _loc4_ = new LandMineSapperInfo();
               _loc4_.userId = _loc2_.userId;
               model.leave(_loc4_);
            }
         }
         else if(_loc2_.op == 2)
         {
            _loc4_ = new LandMineSapperInfo();
            _loc4_.userId = _loc2_.userId;
            _loc4_.posX = _loc2_.posX;
            _loc4_.posY = _loc2_.posY;
            _loc4_.state = _loc2_.state;
            model.move(_loc4_);
            if(_loc2_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               model.posX = _loc2_.posX;
               model.posY = _loc2_.posY;
               model.state = _loc2_.state;
               model.commit();
            }
         }
         else if(_loc2_.op == 3)
         {
            model.posX = -1;
            model.posY = -1;
            model.state = 0;
            model.winnerId = _loc2_.userId;
            model.isWin = _loc2_.isWin;
            model.end();
         }
         else if(_loc2_.op == 4)
         {
            model.sapperDic.clear();
            for each(_loc6_ in _loc2_.sappers)
            {
               _loc4_ = new LandMineSapperInfo();
               _loc4_.userId = _loc6_.userId;
               _loc4_.nickName = _loc6_.nickName;
               _loc4_.arm = _loc6_.arm;
               _loc4_.cloth = _loc6_.cloth;
               _loc4_.wing = _loc6_.wing;
               _loc4_.hat = _loc6_.hat;
               _loc4_.fashionArm = _loc6_.fashionArm;
               _loc4_.fashionCloth = _loc6_.fashionCloth;
               _loc4_.hide = _loc6_.hide;
               _loc4_.posX = _loc6_.posX;
               _loc4_.posY = _loc6_.posY;
               _loc4_.state = _loc6_.state;
               _loc4_.sex = _loc6_.sex;
               _loc4_.job = _loc6_.job;
               _loc4_.templateId = _loc6_.templateId;
               model.sapperDic.add(_loc4_.userId,_loc4_);
            }
            model.rewardCount = _loc2_.rewardCount;
            model.commit();
         }
         else if(_loc2_.op == 5)
         {
            model.rewardCount = _loc2_.rewardCount;
            model.commit();
            MsgMan.notifyObserver("LAND_MINE_INFO_CHANGE");
         }
         else if(_loc2_.op == 6)
         {
            model.cancel();
         }
      }
      
      public function enter() : void
      {
         var _loc2_:PackageOut = new PackageOut(5192);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 0;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function leave() : void
      {
         var _loc2_:PackageOut = new PackageOut(5192);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function move(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(5192);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 2;
         _loc2_.index = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function end() : void
      {
         var _loc2_:PackageOut = new PackageOut(5192);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 3;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function team() : void
      {
         var _loc2_:PackageOut = new PackageOut(5192);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 4;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketSendManager.instance.sendProtoBuffer(param1,param2);
      }
   }
}

