package managers
{
   import com.road.yishi.proto.minigame.MemoryCard;
   import com.road.yishi.proto.minigame.MemoryCardMsg;
   import com.road.yishi.proto.minigame.MemoryCardRewardMsg;
   import events.AirGardenGameEvent;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.airgarden.game.MemoryCardData;
   import mvc.module.airgarden.game.MemoryCardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.HashMap;
   import yishi.utils.SimpleAlertHelper;
   
   public class AirGardenMemoryCardManager extends EventDispatcher
   {
      
      public static const OP_START:int = 1;
      
      public static const OP_FLIP:int = 2;
      
      public static const OP_AUTO:int = 3;
      
      public static const OP_SHOW:int = 4;
      
      public static const OP_CLOSE:int = 5;
      
      private static var _instance:AirGardenMemoryCardManager;
      
      private var _model:MemoryCardModel;
      
      public function AirGardenMemoryCardManager()
      {
         super();
         _model = new MemoryCardModel();
      }
      
      public static function get instance() : AirGardenMemoryCardManager
      {
         if(!_instance)
         {
            _instance = new AirGardenMemoryCardManager();
         }
         return _instance;
      }
      
      public function get model() : MemoryCardModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 194,infoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 195,scoreAwardHandler);
      }
      
      private function infoHandler(param1:SLGSocketEvent) : void
      {
         var tempData:MemoryCardData;
         var temp2:MemoryCard;
         var delay:int;
         var event:SLGSocketEvent = param1;
         var pkg:PackageIn = event.data as PackageIn;
         var msg:MemoryCardMsg = new MemoryCardMsg();
         msg = pkg.readBody(msg) as MemoryCardMsg;
         if(msg.hasAddScore)
         {
            model.addScore = msg.addScore;
         }
         if(msg.hasAddScore2)
         {
            model.addScore2 = msg.addScore2;
         }
         if(msg.hasCurTurn)
         {
            model.curTurn = msg.curTurn;
         }
         if(msg.hasDuration && model.duration <= 0)
         {
            model.duration = msg.duration;
         }
         if(msg.hasLeftAutoChance)
         {
            model.leftAutoChance = msg.leftAutoChance;
         }
         if(msg.hasLeftCheckChance)
         {
            model.leftCheckChance = msg.leftCheckChance;
         }
         if(msg.hasResult)
         {
            model.result = msg.result;
         }
         if(msg.hasScore)
         {
            model.score = msg.score;
         }
         if(msg.hasCIndex1)
         {
            model.cIndex1 = msg.cIndex1;
         }
         if(msg.hasCIndex1)
         {
            model.cIndex2 = msg.cIndex2;
         }
         if(msg.op == 2)
         {
            sendEvent("FLIP_MEMORY_CARD");
         }
         else if(msg.op == 3)
         {
            sendEvent("AUTO_MEMORY_CARD");
         }
         else if(msg.op == 4)
         {
            model.cardShow = new HashMap();
            for each(temp2 in msg.cards)
            {
               tempData = new MemoryCardData(temp2);
               model.cardShow.put(tempData.index,tempData);
            }
            sendEvent("SHOW_MEMORY_CARD");
         }
         else if(msg.cards && msg.cards.length)
         {
            delay = 0;
            if(model.cards && model.cards.size)
            {
               delay = 2000;
            }
            setTimeout(function():void
            {
               model.cards = new HashMap();
               for each(var _loc1_:MemoryCard in msg.cards)
               {
                  tempData = new MemoryCardData(_loc1_);
                  model.cards.put(tempData.index,tempData);
               }
               sendEvent("INIT_MEMORY_CARD");
            },delay);
         }
         sendEvent("UPDATE_DATA_MEMORY_CARD");
      }
      
      private function sendEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new AirGardenGameEvent(param1,param2));
      }
      
      private function scoreAwardHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MemoryCardRewardMsg = new MemoryCardRewardMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MemoryCardRewardMsg;
         var _loc3_:String = LanguageMgr.GetTranslation("AirGardenGame.hint3",_loc2_.score,_loc2_.count);
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc3_,_loc4_,"",false,false,false,1);
      }
      
      public function sendStart() : void
      {
         var _loc2_:PackageOut = new PackageOut(5444);
         var _loc1_:MemoryCardMsg = new MemoryCardMsg();
         _loc1_.op = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendFlip(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5444);
         var _loc3_:MemoryCardMsg = new MemoryCardMsg();
         _loc3_.op = 2;
         _loc3_.cIndex1 = param1;
         _loc3_.cIndex2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendAuto() : void
      {
         var _loc2_:PackageOut = new PackageOut(5444);
         var _loc1_:MemoryCardMsg = new MemoryCardMsg();
         _loc1_.op = 3;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendShow() : void
      {
         var _loc2_:PackageOut = new PackageOut(5444);
         var _loc1_:MemoryCardMsg = new MemoryCardMsg();
         _loc1_.op = 4;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendClose() : void
      {
         var _loc2_:PackageOut = new PackageOut(5444);
         var _loc1_:MemoryCardMsg = new MemoryCardMsg();
         _loc1_.op = 5;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

