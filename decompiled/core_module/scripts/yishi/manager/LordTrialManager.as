package yishi.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.lordtrial.LordTrialOpMsg;
   import manager.LanguageMgr;
   import mvc.module.lordtrial.LordTrialModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class LordTrialManager
   {
      
      private static var _instance:LordTrialManager;
      
      private static var _intervalTime:Number = 0;
      
      private var _model:LordTrialModel;
      
      public function LordTrialManager()
      {
         super();
      }
      
      public static function get instance() : LordTrialManager
      {
         if(!_instance)
         {
            _instance = new LordTrialManager();
         }
         return _instance;
      }
      
      public static function openMainFrame() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 0;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function reset() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function startPray() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 2;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function endPray() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 3;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sacrifice() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 4;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function enterBattle(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9650);
         var _loc3_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc3_.op = 5;
         _loc3_.nowType = param1;
         _loc3_.nowIndex = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendMopup(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9650);
         var _loc3_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc3_.op = 6;
         _loc3_.nowType = param1;
         _loc3_.sweepIndex = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function cancelMopup() : void
      {
         var _loc2_:PackageOut = new PackageOut(9650);
         var _loc1_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc1_.op = 7;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function speedMopup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9650);
         var _loc2_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc2_.op = 8;
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public function get model() : LordTrialModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new LordTrialModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 445,__lordTrialInfoHandler);
      }
      
      private function __lordTrialInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LordTrialOpMsg = new LordTrialOpMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as LordTrialOpMsg;
         if(_loc2_)
         {
            _loc4_ = _loc2_.errorID;
            if(_loc4_ == 8)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.LordTrialManager.todayReset"));
               return;
            }
            if(_loc4_ == 0 && _loc2_.op == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.LordTrialManager.resetSuccess"));
            }
            if(_loc2_.op == 9)
            {
               playerInfo.currentType = _loc2_.nowType;
               playerInfo.currentIndex = _loc2_.nowIndex + 1;
               _loc3_ = {};
               _loc3_.count = _loc2_.nowIndex;
               _loc3_.items = _loc2_.indexItems;
               model.mopupList.push(_loc3_);
               model.updateMopup(_loc3_);
            }
            else
            {
               model.mopupCount = _loc2_.sweepIndex;
               if(playerInfo)
               {
                  playerInfo.lordTrialKeyCount = _loc2_.keyCount;
                  playerInfo.prayCount = _loc2_.prayCount;
                  playerInfo.sacrificeCount = _loc2_.sacrificeCount;
                  playerInfo.lordTrialCard = _loc2_.cards;
                  playerInfo.hpPrecent = _loc2_.hpPercent;
                  playerInfo.petId = _loc2_.petId;
                  playerInfo.childPetId = _loc2_.childPetId;
                  playerInfo.secondChildPetId = _loc2_.secondChildPetId;
                  playerInfo.childId = _loc2_.childId;
                  playerInfo.secondChildId = _loc2_.secondChildId;
                  playerInfo.currentType = _loc2_.nowType;
                  playerInfo.currentIndex = _loc2_.nowIndex + 1;
                  playerInfo.maxIndex = _loc2_.maxIndexs;
                  playerInfo.order = _loc2_.orders;
                  playerInfo.itemTempIds = _loc2_.items;
                  playerInfo.debuffer = _loc2_.debuffs;
                  playerInfo.sweepIndex = _loc2_.sweepIndex;
                  playerInfo.prayStatus = _loc2_.prayStatus;
                  model.childId = _loc2_.childId;
               }
               model.updateView();
            }
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         if(playerModel)
         {
            return playerModel.playerInfo;
         }
         return null;
      }
   }
}

