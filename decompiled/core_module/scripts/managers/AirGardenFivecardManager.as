package managers
{
   import com.road.yishi.proto.minigame.FiveCardPokerMsg;
   import com.road.yishi.proto.minigame.FiveCardPokerRewardMsg;
   import events.AirGardenGameEvent;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import mvc.module.airgarden.game.FivecardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AirGardenFivecardManager extends EventDispatcher
   {
      
      public static const OP_START:int = 1;
      
      public static const OP_NEXT:int = 2;
      
      public static const OP_SHOW:int = 3;
      
      public static const OP_CLOSE:int = 4;
      
      public static const MAX_PLAY_TIME:int = 5;
      
      private static var _instance:AirGardenFivecardManager;
      
      private var _model:FivecardModel;
      
      public function AirGardenFivecardManager()
      {
         super();
         _model = new FivecardModel();
      }
      
      public static function get instance() : AirGardenFivecardManager
      {
         if(!_instance)
         {
            _instance = new AirGardenFivecardManager();
         }
         return _instance;
      }
      
      public function get model() : FivecardModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 192,infoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 193,scoreAwardHandler);
      }
      
      private function infoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:FiveCardPokerMsg = new FiveCardPokerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as FiveCardPokerMsg;
         if(_loc2_.hasCurTurn)
         {
            model.curTurn = _loc2_.curTurn;
         }
         if(_loc2_.hasAddScore && _loc2_.addScore != 0)
         {
            model.addScore = _loc2_.addScore;
            sendEvent("FIVE_CARD_ADD_SCORE");
         }
         if(_loc2_.hasScore)
         {
            model.score = _loc2_.score;
         }
         if(_loc2_.pokers && _loc2_.pokers.length)
         {
            model.updatePokers(_loc2_.pokers);
         }
         if(_loc2_.holdList && _loc2_.holdList.length)
         {
            model.holdList = _loc2_.holdList;
         }
         if(_loc2_.op == 3)
         {
            sendEvent("SHOW_FIVE_CARD");
         }
         else
         {
            sendEvent("INIT_FIVE_CARD");
         }
      }
      
      private function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new AirGardenGameEvent(param1,param2));
      }
      
      private function scoreAwardHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:FiveCardPokerRewardMsg = new FiveCardPokerRewardMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as FiveCardPokerRewardMsg;
         var _loc3_:String = LanguageMgr.GetTranslation("AirGardenGame.hint3",_loc2_.score,_loc2_.count);
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc3_,_loc4_,"",false,false,false,1);
      }
      
      public function sendStart() : void
      {
         var _loc2_:PackageOut = new PackageOut(5443);
         var _loc1_:FiveCardPokerMsg = new FiveCardPokerMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendNext() : void
      {
         var _loc2_:PackageOut = new PackageOut(5443);
         var _loc1_:FiveCardPokerMsg = new FiveCardPokerMsg();
         _loc1_.op = 2;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendShow(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(5443);
         var _loc2_:FiveCardPokerMsg = new FiveCardPokerMsg();
         _loc2_.op = 3;
         _loc2_.holdList = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendClose() : void
      {
         var _loc2_:PackageOut = new PackageOut(5443);
         var _loc1_:FiveCardPokerMsg = new FiveCardPokerMsg();
         _loc1_.op = 4;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

