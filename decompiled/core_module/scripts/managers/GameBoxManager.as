package managers
{
   import com.road.yishi.proto.gamebox.GameBoxInfoMsg;
   import manager.LanguageMgr;
   import mvc.module.gamebox.GameBoxModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GameBoxManager
   {
      
      private static var _instance:GameBoxManager;
      
      private var _model:GameBoxModel;
      
      public function GameBoxManager()
      {
         super();
         _model = new GameBoxModel();
      }
      
      public static function get instance() : GameBoxManager
      {
         if(!_instance)
         {
            _instance = new GameBoxManager();
         }
         return _instance;
      }
      
      public function get mode() : GameBoxModel
      {
         if(_model == null)
         {
            _model = new GameBoxModel();
         }
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 256,onInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 257,onOpenGame);
      }
      
      public function getData() : void
      {
         var _loc2_:PackageOut = new PackageOut(9559);
         var _loc1_:GameBoxInfoMsg = new GameBoxInfoMsg();
         _loc1_.op = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function exchangeItem(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9559);
         var _loc2_:GameBoxInfoMsg = new GameBoxInfoMsg();
         _loc2_.op = 3;
         _loc2_.exchangeIndex = param1;
         _loc2_.exchangeCount = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function starGame(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9559);
         var _loc2_:GameBoxInfoMsg = new GameBoxInfoMsg();
         _loc2_.op = 2;
         _loc2_.starGameId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function onInfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GameBoxInfoMsg = new GameBoxInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GameBoxInfoMsg;
         if(_loc2_.hasTempId1)
         {
            _model.info.tempId1 = _loc2_.tempId1;
         }
         if(_loc2_.hasTempId2)
         {
            _model.info.tempId2 = _loc2_.tempId2;
         }
         if(_loc2_.hasTempId3)
         {
            _model.info.tempId3 = _loc2_.tempId3;
         }
         if(_loc2_.hasTempId4)
         {
            _model.info.tempId4 = _loc2_.tempId4;
         }
         if(_loc2_.hasGameBoxMedal)
         {
            _model.info.gameBoxMedal = _loc2_.gameBoxMedal;
         }
         if(_loc2_.op == 1)
         {
            NotificationManager.instance.sendNotification("GAME_BOX_INFO");
         }
      }
      
      private function onOpenGame(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GameBoxInfoMsg = new GameBoxInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GameBoxInfoMsg;
         if(_loc2_.op == 2)
         {
            try
            {
               this["enterGame" + _loc2_.starGameId]();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function enterGame1() : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.teamNotice"));
            return;
         }
         if(thane.grades >= 28)
         {
            FishManager.instance.fishAction(4);
            FishManager.instance.fishAction(1,[10,20]);
            FishManager.instance.model.fishPoolInfo.userId = playerModel.userInfo.userId;
            FrameControllerManager.instance.openControllerByInfo("fish");
         }
         FishManager.instance.model.fishRefuseInvitation = SharedManager.instance.refuseInvitation;
         FishManager.instance.model.fishRefuseInvite = playerModel.playerInfo.refuseInvite;
         FishManager.instance.model.fishRefuseTeamInvite = playerModel.playerInfo.refuseTeamInvite;
         if(!FishManager.instance.model.fishRefuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!FishManager.instance.model.fishRefuseInvitation)
         {
            SharedManager.instance.refuseInvitation = !FishManager.instance.model.fishRefuseInvitation;
            SharedManager.instance.save();
         }
         if(!FishManager.instance.model.fishRefuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function enterGame2() : void
      {
         FrameControllerManager.instance.gemMazeController.startFrameByType(1);
      }
      
      private function enterGame4() : void
      {
         SceneManager.instance.setScene("FINAL_DEFENSE_SCENE");
      }
   }
}

